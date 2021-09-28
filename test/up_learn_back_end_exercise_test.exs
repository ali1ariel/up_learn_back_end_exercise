defmodule UpLearnBackEndExerciseTest do
  use ExUnit.Case

  alias UpLearnBackEndExercise.Elements.Link
  alias UpLearnBackEndExercise.Elements.Asset

  @invalid_url "http://example.com/invalid"
  @valid_url "http://example.com/list"
  @redirected_url "http://example.com/redirect"

  test "properly parses html from the site and returns a list {:ok, list}" do
    expect_http(@valid_url, 200, File.read!("test/test.html"))

    {:ok, list} = UpLearnBackEndExercise.fetch(@valid_url)
    assert is_list(list)
    assert %Link{href: "oi"} in list
    assert %Asset{src: "image"} in list
  end

  test "returns error in case of redirect" do
    expect_http(@redirected_url, 301, "redirect")

    assert {:error, 301} == UpLearnBackEndExercise.fetch(@redirected_url)
  end

  test "returns error in case of not found" do
    expect_http(@redirected_url, 404, "not found")

    assert {:error, 404} == UpLearnBackEndExercise.fetch(@redirected_url)
  end

 def expect_http(expected_url, return_status, return_body) do
    Tesla.Mock.mock(
      fn %{method: :get, url: url} ->
        assert url ==  expected_url
        %Tesla.Env{status: return_status, body: return_body}
    end)
  end
end
