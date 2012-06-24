require 'spec_helper'

def get_movie
  get :find_similar_movies, { id: 1 }
end

describe MoviesController do

  let(:movies) { [mock("movie one"), mock("movie two")] }
  let(:movie) { mock("movie one", director: nil, title: "title") }

  describe "#by_movie_director" do
    it "calls Movie.find to retrieve the Movie record" do
      Movie.should_receive(:find).and_return(movie)
      get_movie
    end

    context "Movie has a director" do
      before(:each) do
        Movie.stub(:find).and_return(movie)
        movie.stub(:director).and_return(true)
        Movie.stub(:by_movie_director).and_return(movies)
      end

      it "retrieves a list of films by movie director"  do
        get_movie

        assigns(:movies).should == movies
      end

      context "list of movies returned" do
        it "renders template by_movie_director" do
          get_movie
          response.should render_template(:find_similar_movies)
        end
      end
    end

    context "Movie has no director" do
      it "set flash notice" do
        Movie.stub(:find).and_return(movie)
        movie.stub(:director).and_return(nil)
        get_movie

        flash[:notice].should =~ /has no director info/
      end

      it "redirects to movies index" do
        Movie.stub(:find).and_return(movie)
        movie.stub(:director).and_return(nil)
        get_movie

        response.should redirect_to movies_path
      end
    end
  end

end
