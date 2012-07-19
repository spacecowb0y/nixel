#!/usr/bin/env ruby

require 'rubygems'
require 'aws/s3'
require 'zipruby'
require 'fileutils'
require 'uri'

S3_KEY_ID     = "AKIAJDJYZLENUVGORZ4A"
S3_ACCESS_KEY = "jNSTRX2I0CA9ffotUi/ieNJCAQNYNhL+tzunVnbr"
TMP_FOLDER    = "#{File.expand_path File.dirname(__FILE__)}/tmp"

AWS::S3::Base.establish_connection!(
  :access_key_id     => S3_KEY_ID,
  :secret_access_key => S3_ACCESS_KEY
)

def download_file_from_s3_url(url)
  download_file_from_s3(URI(url).host, URI(url).path.slice!(1..-1))
end

def download_file_from_s3(bucket, filename)
  s3_attachment  = AWS::S3::S3Object.find filename, bucket
  tmp_attachment = "#{TMP_FOLDER}/#{File.basename(s3_attachment.key)}"

  if !File.exists?(tmp_attachment) || File.size(tmp_attachment) != s3_attachment.about[:content_length].to_i
    puts "Descargando archivo #{File.basename(s3_attachment.key)} a #{tmp_attachment}..."
    open(tmp_attachment, 'w') do |file|
      AWS::S3::S3Object.stream(s3_attachment.key, bucket) do |data|
        file.write(data)
      end
    end
    puts "Archivo descargado con exito."
  else
    puts "El archivo ya fue descargo con exito anteriormente."
  end
  
  return tmp_attachment
end

def unzip_files(filename)
  dir          = "#{TMP_FOLDER}/#{File.basename(filename, ".*")}"
  markup_files = Dir.glob(File.join("**", "*.html"))

  puts "Iniciando proceso de descompresion en #{dir}..."

  Zip::Archive.open(filename) do |ar|
    ar.each do |zf|
      if zf.directory?
        FileUtils.mkdir_p("#{dir}/#{zf.name}")
      else
        dirname = File.dirname("#{dir}/#{zf.name}")
        FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
        open("#{dir}/#{zf.name}", 'wb') do |f|
          f << zf.read
        end
      end
      puts "Descomprimiendo archivo: #{File.basename(zf.name)}..."
    end
  end

  puts "Todos los archivos fueron descomprimidos correctamente en #{dir}."
  puts "Estos son todos los archivos del markup: #{markup_files}"
end