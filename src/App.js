import React from 'react';
import './App.css';

function App() {
  const handleClick = () => {
    alert('Button clicked!');
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Hello World</h1>
        <button onClick={handleClick}>Click Me</button>
      </header>
    </div>
  );
}

export default App;
