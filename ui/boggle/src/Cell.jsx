import React from 'react';

function Cell(props) {
    let {letter, addLetter} = props;
    let renderText = letter.toUpperCase();
    if (renderText === 'q') {
        renderText = 'Qu'
    }

    function handleClick(e) {
        e.preventDefault();
        addLetter(letter);
    }

    return <button disabled={props.disabled} className={"cell"} onClick={handleClick}>{renderText}</button>
}

export default Cell