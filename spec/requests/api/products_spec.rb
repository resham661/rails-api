require 'swagger_helper'

RSpec.describe 'api/products', type: :request do

  path '/api/v1/products' do
    
    post 'Creates a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number },
          brand: { type: :string }
        },
        required: [ 'name', 'price', 'brand' ]
      }

      response '201', 'product created' do
        let(:product) { { name: 'Earphone', price: 5000, brand: 'Boat' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { name: 'Eaphone'} }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}' do

    get 'Retrieves a Product' do
      # tags 'Product', 'Another Tag'
      tags 'Products'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Foo'}, name: 'basic', summary: 'Request example description'

      response '200', 'product found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            price: { type: :number },
            brand: { type: :string }
          },
          required: [ 'id', 'name', 'price', 'brand' ]
        
        let(:id) { Product.create(name: 'Earphone', price: 500, brand: 'Boat').id }
        run_test!
      end

      response '404', 'product not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/Earphone' }
        run_test!
      end
    end
  end

  path '/api/v1/products' do

    get 'List of Products' do
      tags 'Products'
      response(200, 'Successful') do
        
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    patch 'update product' do
      tags 'Products'

      response(200, 'successful') do
        # let(:id) { '123' }

        consumes 'application/json'
        parameter name: :product, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string},
            price: { type: :number},
            brand: { type: :string}
          },
          required: ['name', 'price', 'brand']
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  # end

  # path '/api/v1/products/{id}' do
    # parameter name: 'id', in: :path, type: :string, description: 'id'

    put 'update product' do
      tags 'Products'

      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :product, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            price: { type: :number},
            brand: { type: :string}
          },
          required: %w[name price brand]
        }
        # let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  # end

  # path '/api/v1/products/{id}' do
    # parameter name: 'id', in: :path, type: :string, description: 'id'
    
    delete 'delete Product' do
      tags 'Products'

      response(200, 'successful') do
        let(:id) { '123'}

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
