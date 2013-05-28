namespace :demo do
  task :environment do
    require 'rubygems'
    require 'bundler'
    Bundler.require

    require 'simple_shipping'
    require 'RMagick'
  end

  namespace :fedex do
    desc 'Call real FedEx API with shipment_request'
    task :shipment_request, [:output_filename] => :environment do |task, args|
      args.with_defaults(:output_filename => File.join(Dir.tmpdir, 'fedex_shipment_request_output.png'))

      demo = SimpleShipping::Demo::Fedex.new
      demo.override_options_from_env
      resp = demo.shipment_request
      img = Magick::Image.read_inline(resp.label_image_base64).first

      img.write(args[:output_filename])
      puts "Label received. #{args[:output_filename]} written"
    end
  end

  namespace :ups do
    desc 'Call real UPS API with shipment_request'
    task :shipment_request, [:output_filename] => :environment do |task, args|
      args.with_defaults(:output_filename => File.join(Dir.tmpdir, 'ups_shipment_request_output.png'))

      demo = SimpleShipping::Demo::Ups.new
      demo.override_options_from_env

      resp = demo.shipment_request
      img = Magick::Image.read_inline(resp.label_image_base64).first

      img.write(args[:output_filename])
      puts "Label received. #{args[:output_filename]} written"
    end

    desc 'Call real UPS API with void_request'
    task :void_request => :environment do
      demo = SimpleShipping::Demo::Ups.new
      demo.override_options_from_env

      begin
        resp = demo.void_request
      rescue SimpleShipping::RequestError => exc
        raise exc unless exc.message =~ /No shipment found within the allowed void period/
      end
    end
  end
end
