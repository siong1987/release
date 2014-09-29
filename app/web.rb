require 'sinatra'
require 'octokit'
require 'byebug'

class Web < Sinatra::Base
  def client
    @client ||= Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
  end

  get '/' do
    'Hello world!'
  end

  get '/repos' do
    @repos = client.repositories(ENV['GITHUB_ORGANIZATION'])
    erb :repos, layout: :app
  end

  get '/repos/:name' do
    # @releases = client.releases("#{ENV['GITHUB_ORGANIZATION']}/#{params[:name]}")
    @releases = client.releases("siong1987/rails")

    erb :repo, layout: :app
  end

  get '/repos/:name/release' do
    @repo_name = params[:name]
    @issues = client.list_issues("siong1987/rails", state: :closed, since: params[:published_at])
    erb :release, layout: :app
  end
end
