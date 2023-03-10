defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Create a deck of 20 cards, 1 to 5 of Spades, Clubs, Hearts and Diamonds.

      iex> Cards.create_deck
  """
  def create_deck do
    # values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight" , "Nine", "Ten", "Jack", "Queen", "King"]
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Randomize cards order on deck

      iex> deck = Cards.create_deck
      iex> shuffled_deck = Cards.shuffle(deck)
  """

  def shuffle(deck) do
    Enum.shuffle(deck)
  end


  @doc """
    Determines wheter a deck contains a given card

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Hearts")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a hand an the reminder of the deck.
    The `hand_size` argument indicates how many cards should be in hand.

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 3)
      iex> hand
      ["Ace of Spades", "Two of Spades", "Three of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves current deck on a file.

      iex> deck = Cards.create_deck
      iex> Cards.save(deck, "my_deck")
      :ok
  """

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a deck form a file.

      iex> deck = Cards.create_deck
      iex> Cards.save(deck, "my_deck")
      :ok
      iex> new_deck = Cards.load("my_deck")
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
        "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
        "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
        "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
        "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist"
    end
  end

  @doc """
    Creates a new deck, shuffles it, and return a hand.
    `hand_size` indicates how many cards will be returned.

    This is a shortcut for:
      iex> deck = Cards.create_deck
      iex> shuffled_deck = Cards.shuffle(deck)
      iex> Cards.deal(shuffled_deck, 5)
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
