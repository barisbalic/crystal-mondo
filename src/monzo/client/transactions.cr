module Monzo
  class Client

    # Exposes methods for dealing with `Transaction`s and manipulating their annotations/metadata, as defined by
    # the [Transaction API documentation](https://monzo.com/docs/#transactions).
    module Transactions

      # Returns `Transaction`s for the specified *account*.
      #
      # ```
      # account = client.accounts.first
      # client.transactions(account) # => [#<Monzo::Transaction:0x104163f00 @id="tx_TRANSACTIONID", @amount=10000, @currency="GBP", ... >]
      # ```
      def transactions(account : Account)
        transactions(account.id)
      end

      # Returns `Transaction`s for the specified *account_id*.
      def transactions(account_id : String)
        response = get("/transactions?account_id=#{account_id}&expand[]=merchant")
        Array(Monzo::Transaction).from_json(response, root: "transactions")
      end

      # Returns a `Transaction` for the specified *transaction_id*.
      #
      # ```
      # client.transaction("tx_TRANSACTIONID") #=> #<Monzo::Transaction:0x104163f00 @id="tx_TRANSACTIONID", @amount=10000, ... >]
      # ```
      def transaction(transaction_id : String)
        response = get("/transactions/#{transaction_id}?expand[]=merchant")
        Monzo::Transaction.from_json(response, root: "transaction")
      end

      # Applies an annotation to the specified *transaction*.
      #
      # ```
      # transaction = client.transactions.first
      # client.annotate(transaction, "Rating", "Best coffee in London") # => #<Monzo::Transaction:0x104163f00 @id="tx_TRANSACTIONID", @metadata={"Rating"=>"Best coffee in London"}, ... >]
      # ```
      def annotate(transaction : Monzo::Transaction, name : String, value : String)
        annotate(transaction.id, [{name, value}])
      end

      # Applies an annotation to a `Transaction` with the specified *transaction_id*.
      def annotate(transaction_id : String, name : String, value : String)
        annotate(transaction_id, [{name, value}])
      end

      # Applies multiple annotations to the specified *transaction*.
      #
      # ```
      # transaction = client.transactions.first
      # client.annotate(transaction, [{"Vegan", "Pretty good"}, {"Veggie", "Everything is veggie"}]) # => #<Monzo::Transaction:0x104163f00 @id="tx_TRANSACTIONID", @metadata={"Vegan"=>"Pretty good.", "Veggie"=>"Everything is veggie."}, ... >]
      # ```
      def annotate(transaction : Monzo::Transaction, annotations : Array(Tuple(String, String)))
        annotate(transaction.id, annotations)
      end

      # Applies multiple annotations to a `Transaction` with the specified `transaction_id`.
      def annotate(transaction_id : String, annotations : Array(Tuple(String, String)))
        params = HTTP::Params.build do |query|
          annotations.each do |name, value|
            query.add "metadata[#{name}]", value
          end
        end

        response = patch("/transactions/#{transaction_id}", params)
        Monzo::Transaction.from_json(response, root: "transaction")
      end

      # Removes an annotation from the specified *transaction*.
      #
      # ```
      # transaction = client.transactions.first # => #<Monzo::Transaction:0x104163f00 @id="tx_TRANSACTIONID", @metadata={"Rating"=>"Best coffee in London"}, ... >]
      # client.remove_annotation(transaction, "Rating") # => #<Monzo::Transaction:0x104163f00 @id="tx_TRANSACTIONID", @metadata={}, ... >]
      # ```
      def remove_annotation(transaction : Monzo::Transaction, key : String)
        remove_annotations(transaction.id, [key])
      end

      # Remvoes an annotation from a `Transaction` with the specified *transaction_id*.
      def remove_annotation(transaction_id : String, key : String)
        remove_annotations(transaction_id, [key])
      end

      # Removes multiple annotations from the specified *transaction*.
      #
      # ```
      # transaction = client.transactions.first # => #<Monzo::Transaction:0x104163f00 @id="tx_TRANSACTIONID", @metadata={"Vegan"=>"Pretty good.", "Veggie"=>"Everything is veggie."}, ... >]
      # client.remove_annotations(transaction, ["Vegan", "Veggie"]) # => #<Monzo::Transaction:0x104163f00 @id="tx_TRANSACTIONID", @metadata={}, ... >]
      def remove_annotations(transaction : Monzo::Transaction, keys : Array(String))
        remove_annotations(transaction.id, keys)
      end

      # Remove multiple anntatons from a `Transaction` with the specifed *transaction_id*.
      def remove_annotations(transaction_id : String, keys : Array(String))
        annotations = keys.map { |key| {key, ""} }
        annotate(transaction_id, annotations)
      end
    end
  end
end
