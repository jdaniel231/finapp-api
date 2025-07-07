class RedeCardTransactionService
  def self.process(transaction_data)
    # Tenta encontrar uma transação existente pelo TID
    existing_transaction = RedeCardTransaction.find_by(tid: transaction_data[:tid])

    if existing_transaction
      Rails.logger.info "Transação com TID #{transaction_data[:tid]} já existe. Ignorando criação duplicada."
      # Opcional: Adicionar lógica para atualizar a transação existente se necessário
      existing_transaction
    else
      # Cria uma nova transação se não existir
      RedeCardTransaction.create!(
        tid: transaction_data[:tid],
        nsu: transaction_data[:nsu],
        authorization_code: transaction_data[:authorizationCode],
        response_code: transaction_data[:responseCode],
        response_message: transaction_data[:responseMessage],
        amount: transaction_data[:amount],
        installments: transaction_data[:installments],
        card_brand: transaction_data[:brand]
      )
    end
  rescue StandardError => e
    Rails.logger.error "Erro ao processar transação da Rede: #{e.message}"
    # Você pode querer re-raise o erro ou retornar um valor específico
    nil
  end
end
