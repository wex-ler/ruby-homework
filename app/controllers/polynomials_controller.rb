class PolynomialsController < ApplicationController
    def show
        @solution = Marshal.restore(Base64.decode64(params[:id]))
    end

    def new
    end

    def create
        a = params[:a].to_i
        b = params[:b].to_i
        c = params[:c].to_i
        d = params[:d].to_i
    
        solution = Base64.encode64(Marshal.dump(solve(a, b, c, d)))
    
        redirect_to "/polynomials/#{solution}"
    end
end

def solve(a, b, c, d)
    require 'cmath'

    a = a.to_r
    b = b.to_r
    c = (c - d).to_r

    first  = -1 * b / 2
    second = CMath.sqrt(b ** 2 - 4 * a * c) / (2 * a)

    [first - second, first + second]
end