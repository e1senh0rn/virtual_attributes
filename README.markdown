# VirtualAttributes

* https://github.com/daemon/virtual_attributes

## DESCRIPTION

Usually you can use `attr_accessor` to define virtual attribute.
You could even use `attr_accessor_with_default` to set default value.

But in any case you are unable to typecast values.

Let's assume you receive data from form submit.

    > params[:user].inspect
    => {'enabled' => 'true', 'priority' => '0.5'}

Having attributes defined as table columns values would be actual `true` and `0.5`.

But with `attr_accessor` fields will still be strings.

This is what `virtual_attribute` handles.

## Origins

Inspired with virtual_attribute gem by Philip Roberts I tried to use ActiveRecord to typecast.

## Usage

    class User < ActiveRecord::Base
      virtual_attribute :enabled,  :type => :boolean, :default => false
      virtual_attribute :priority, :type => :float,   :default => 1.0
    end

