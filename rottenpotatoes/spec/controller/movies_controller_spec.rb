require 'rails_helper'
 describe MoviesController, :type => :controller do
    
    before(:each) do
        @movie_1 = Movie.create(title: "title_1",rating: "G", description:"we are here", director: "abc123",release_date: 20161123)
    end
    
    describe "#index" do
        it "should have response" do
            get :index
            expect(response).to have_http_status(200)
            expect(response).to render_template(:index)
        end
        it "should have sort with title" do
            allow(controller).to receive(:params).and_return({:sort => "title"})
            get :index
            expect(controller.params[:sort]).to eq("title")
        end
        it "should have sort with release date" do
            allow(controller).to receive(:params).and_return({:sort => "release_date"})
            get :index
            expect(controller.params[:sort]).to eq("release_date")
        end
        
    end
    
    describe "#new" do
        before(:each) do
            @movies_params = {title: "title_1",rating: "G",director: "abc123",release_date: 20161123}
        end
        
        it "new movie" do
            get :new,  movie_id: @movie_1[:id]
            expect(Movie.find(@movie_1.id)[:title]).to eq("title_1")
            expect(response).to have_http_status(200)
            expect(response).to render_template(:new)
        end
    end
    
    it "#show" do
        get :show, id: @movie_1[:id]
        expect(response).to render_template(:show)
    end
    
    it "#edit" do
        get :edit, id: @movie_1[:id]
        expect(response).to render_template(:edit)
    end
    
    describe "#update" do
        before(:each) do
            @movie_backup= {:title => @movie_1.title, :rating => @movie_1.rating, :director => @movie_1.director, :release_date => @movie_1.release_date}
            @movie_params= {:title => "title_1", :rating => "PG", :director => "abc",:release_date => 20161118}
        end
        
        it "update movie" do
            put :update,  id: @movie_1[:id], movie:@movie_params
            expect(Movie.find(@movie_1[:id])[:director]).to eq(@movie_params[:director])
        end
        
        it "restore movie" do
            put :update, id: @movie_1[:id], movie: @movie_backup
            expect(Movie.find(@movie_1[:id])[:director]).to eq(@movie_backup[:director])
        end
    end
    
    describe "#destroy" do
        before(:each) do
            @movie_2 = Movie.create(title: "title_1",rating: "G",director: "abc123",release_date: 20161123)
        end
        it "destroy movie" do
            expect{ delete :destroy, id: @movie_2[:id]}.to change{Movie.all.count}.by(-1)
        end 
         it "redirect_to index after destroy" do
            delete :destroy, id: @movie_1[:id]
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(movies_path)
        end
    end
    
    describe "#create" do
        before(:all) do
            @movie_params = {title: "title_1",rating: "G", description: "wer are here", director: "changed",release_date: 20161123}
        end
        
        it "create movie" do
          expect{post :create, movie: @movie_params}.to change{Movie.all.size}.by(1)
        end
    end 
    
    describe "with samedirector director action" do
        before(:each) do
            @movie_2 = Movie.create(:id => "123", title: "title_2", director: "wpq")
        end
        
        it "return sad path if no director" do
            @movie_4 = Movie.create(:id => "789", title: "title_4", director: nil)
            get :same_director,  id: @movie_4[:id]
            expect(response).to redirect_to(movies_path)
        end
        
        it "return happy path if director exists" do
            @movie_3 = Movie.create(:id => "456", title: "title_3", director: "wpq")
            get :same_director,  id: @movie_3[:id]
            expect(Movie.where(:director => @movie_3.director).size).to eq(2)
        end
    end
    
end