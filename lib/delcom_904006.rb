#!/usr/bin/env ruby
#
# Author: Ian Leitch <ian@envato.com>
# Copyright 2010 Envato
# Author: chris@playup.com

require 'rubygems'
require 'usb'

module Delcom
  class SignalIndicator

    FLASH_N = 10
    FLASH_DURATION = 0.3

    COLORS = {
      :off       => "\x00",
      :green     => "\x01",
      :red       => "\x02",
      :yellow    => "\x03",
      :blue      => "\x04",
      :bluegreen => "\x05",
      :purple    => "\x06",
      :white     => "\x07"
    }

    COLORS.each { |k,v|
      define_method k do msg(v) end
    }

    def self.devices
      @devices ||= USB.devices.select {|device| device.idVendor == VENDOR_ID && device.idProduct == PRODUCT_ID}.tap { |devices|
        raise "Unable to find delcom device(s)" unless devices
      }
    end

    def initialize(device_number=0)
      @device = self.class.devices[device_number]
    end

    def flash(color, options)
      p n        = options[:n]        || FLASH_N
      p duration = options[:duration] || FLASH_DURATION
      (1..n).each {
        send(color)
        sleep duration
        off
        sleep duration
      }
    end

    private

    VENDOR_ID = 0x0fc5
    PRODUCT_ID = 0xb080
    INTERFACE_ID = 0

    def close
      handle.release_interface(INTERFACE_ID)
      handle.usb_close
      @handle = nil
    end

    def msg(data)
      handle.usb_control_msg(0x21, 0x09, 0x0635, 0x000, "\x65\x0C#{data}\xFF\x00\x00\x00\x00", 0)
    end

    def handle
      @handle ||= @device.usb_open.tap { |h|
        begin
          # ruby-usb bug: the arity of rusb_detach_kernel_driver_np isn't defined correctly, it should only accept a single argument.
          if USB::DevHandle.instance_method(:usb_detach_kernel_driver_np).arity == 2
            h.usb_detach_kernel_driver_np(INTERFACE_ID, INTERFACE_ID)
          else
            h.usb_detach_kernel_driver_np(INTERFACE_ID)
          end
        rescue Errno::ENODATA => e
          # Already detached
        end
        h.set_configuration(@device.configurations.first)
        h.claim_interface(INTERFACE_ID)
      }
    end
  end
end

if __FILE__ == $0
  device_number = ARGV.size == 1 ? ARGV[0].to_i : 0
  Delcom::SignalIndicator.new(device_number).yellow
end
