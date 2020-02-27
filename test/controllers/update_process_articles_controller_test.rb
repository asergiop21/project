require 'test_helper'

class UpdateProcessArticlesControllerTest < ActionController::TestCase
  setup do
    @update_process_article = update_process_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:update_process_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create update_process_article" do
    assert_difference('UpdateProcessArticle.count') do
      post :create, update_process_article: { failed: @update_process_article.failed, percentage: @update_process_article.percentage, supplier_id: @update_process_article.supplier_id, updated: @update_process_article.updated, user_id: @update_process_article.user_id }
    end

    assert_redirected_to update_process_article_path(assigns(:update_process_article))
  end

  test "should show update_process_article" do
    get :show, id: @update_process_article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @update_process_article
    assert_response :success
  end

  test "should update update_process_article" do
    patch :update, id: @update_process_article, update_process_article: { failed: @update_process_article.failed, percentage: @update_process_article.percentage, supplier_id: @update_process_article.supplier_id, updated: @update_process_article.updated, user_id: @update_process_article.user_id }
    assert_redirected_to update_process_article_path(assigns(:update_process_article))
  end

  test "should destroy update_process_article" do
    assert_difference('UpdateProcessArticle.count', -1) do
      delete :destroy, id: @update_process_article
    end

    assert_redirected_to update_process_articles_path
  end
end
