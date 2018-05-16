import React, { Component } from 'react';
import './App.css';
import Category from './components/Category'

class App extends Component {
  constructor() {
    super()
    this.state = {categories: [],
                  selectedCategory: null}
    this.getCategories = this.getCategories.bind(this)
  }

  componentDidMount() {
    this.getCategories()
  }

  api_call (url) {
    return new Promise((resolve, reject) => {
      window.fetch(url, {
        headers: {
          "Content-Type": "application/json"
        }
      }).then(response => response.json())
        .then(json => resolve(json))
        .catch(error => reject(error))
    })
  }

  getCategories () {
    this.api_call('/categories.json')
      .then(categories => {
        this.setState({categories: categories})
      })
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Photo A Day</h1>
        </header>

        {this.state.categories.map(category =>
          <Category category={category} key={category.id} />
        )}
      </div>
    );
  }
}

export default App;
