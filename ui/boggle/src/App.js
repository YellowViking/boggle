import React, {Component} from 'react';
import logo from './logo.svg';
import './App.css';
import Cell from "./Cell";
import axios from 'axios';

function Board(props) {
    let {board} = props;
    console.log(board);
    if (board)
        return board.map((row, rowIndex) =>
            <div key={rowIndex}>{row.map((letter, colIndex) => <Cell key={colIndex}
                                                                     letter={letter} {...props}/>)}</div>)
    else {
        return <p>Fetching... board</p>
    }
}

class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            message: undefined,
            word: "",
            pending: false,
            board: undefined
        };
        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
        this.addLetter = this.addLetter.bind(this);
    }

    async componentDidMount() {
        this.setState({board: (await axios.get('/game')).data})
    }

    handleChange(event) {
        this.setState({word: event.target.value});
    }

    async handleSubmit(event) {
        event.preventDefault();
        let {board, word} = this.state;
        this.setState({pending: true, message: 'validating your answer'});
        let result = (await axios.post('/validate', {board, word})).data;
        this.setState({pending: false, message: result ? 'You got it!' : 'oops! try again!'})
    }

    addLetter(letter) {
        this.setState({word: this.state.word + letter})
    }

    render() {
        return (
            <div className="App">
                <header className="App-header">
                    <img src={logo} className="App-logo" alt="logo"/>
                    <p>
                        Click on the Cell to add a letter
                    </p>
                    <form onSubmit={this.handleSubmit}>
                        <label>
                            Your Input:
                            <input type="text" name="name" value={this.state.word} onChange={this.handleChange}/>
                        </label>
                        <Board addLetter={this.addLetter} board={this.state.board} disabled={this.state.pending}/>
                        {this.state.message && <p>{this.state.message}</p>}
                        <input type="submit" value="Check!" disabled={this.state.pending}/>
                    </form>
                </header>
            </div>
        );
    }
}

export default App;
