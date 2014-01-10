namespace :demo do
  task :environment do
    require 'rubygems'
    require 'bundler'
    Bundler.require

    $LOAD_PATH.unshift File.expand_path('../../', __FILE__)

    require 'simple_shipping'
    require 'RMagick'
  end


  namespace :fedex do
    desc 'Call real FedEx API with shipment_request'
    task :shipment_request, [:credentials_file, :output_filename] => :environment do |task, args|
      args.with_defaults(:output_filename => File.join(Dir.tmpdir, 'fedex_shipment_request_output.png'))

      credentials = YAML.load_file(args[:credentials_file])['fedex'].symbolize_keys!

      demo = SimpleShipping::Demo::Fedex.new(credentials)
      resp = demo.shipment_request
      img  = Magick::Image.read_inline(resp.label_image_base64).first

      img.write(args[:output_filename])
      puts "Label received. #{args[:output_filename]} written"
    end
  end

  namespace :ups do
    desc 'Call real UPS API with shipment_request'
    task :shipment_request, [:credentials_file, :output_filename] => :environment do |task, args|
      args.with_defaults(:output_filename => File.join(Dir.tmpdir, 'ups_shipment_request_output.png'))

      credentials = YAML.load_file(args[:credentials_file])['ups'].symbolize_keys!

      demo = SimpleShipping::Demo::Ups.new(credentials)

      resp = demo.shipment_request
      img  = Magick::Image.read_inline(resp.label_image_base64).first

      img.write(args[:output_filename])
      puts "Label received. #{args[:output_filename]} written"
    end

    desc 'Call real UPS API with void_request'
    task :void_request, [:credentials_file] => :environment do |task, args|
      credentials = YAML.load_file(args[:credentials_file])['ups'].symbolize_keys!
      demo = SimpleShipping::Demo::Ups.new(credentials)

      begin
        resp = demo.void_request
      rescue SimpleShipping::RequestError => exc
        raise exc unless exc.message =~ /No shipment found within the allowed void period/
      end
    end
  end
end
