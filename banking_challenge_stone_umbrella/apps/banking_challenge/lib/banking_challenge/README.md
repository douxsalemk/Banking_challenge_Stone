

- Account
  - number account
  - saldo

- Transaction
  - from_account: reference number account
  - to_account
  - amount 
  
  - account_id

t1 = {
    
    from_account = 123
    to account = 234

    amount = 100
}

t2 = {

    from account = 123
    to_account = _

    amount 50
}

## in account

    # OK
    def conferir_saldo(number_account) when is_number(number_account) do
        select balance
        from Account
        where Account.number_account = number_account;
    end


## in transaction

    # ok
    def lista_todas as transaction(number_account) when is_number(number_account) do
    
       select *
       from Transaction as t
       where t.from_account = number_account or t.to_account = number_account;
    end

   
    def transferir_dinheiro(params) when is_map(params) do
    # params = %{from:, to:, amounth}
      {:ok, params} <- changeset(params)
      - verificar se conta de origem existe
      - veriificar se existe balance in conta de origem
      se existe:
        - verificar se conta de destino exite

      - criar a new transaction

        balance _conta de origem = balance conta de origem - amount
        balance conta de destino = balance conta de origem + amount
    end

   
    def sacar_dinheiro (params) do
    # params = %{from, to: nil, amounth}
      {ok, params} <- changeset(params)
      - verificar se conta de origem existe
      - verificar se existe balance in conta de origem
    
      - criar a new transaction

      balance_conta de origem = balance conta de origem - amount 
    end
