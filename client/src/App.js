import React, { Component } from 'react';
import './App.css';
import Category from './components/Category'
import CategoryDetail from './components/CategoryDetail'

class App extends Component {
  constructor() {
    super()
    this.state = {categories: [],
                  selectedCategory: null,
                  selectedSubject: null};
    this.getCategories = this.getCategories.bind(this);
    this.getCategory = this.getCategory.bind(this);
    this.getSubject = this.getSubject.bind(this);
  }

  componentDidMount() {
    this.getCategories()
  }

  api_call(url) {
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

  getCategories() {
    this.api_call('/categories.json')
      .then(categories => {
        this.setState({
          categories: categories,
        })
        this.getCategory(categories[0].id)
      })
  }

  getCategory = (id) => {
    this.api_call('/categories/' + id + '.json')
      .then(category => {
        this.setState({selectedCategory: category});
        this.getSubject(category.subjects[0].id);
      })
  }

  getSubject = (id) => {
    this.api_call('/subjects/' + id + '.json')
      .then(subject => this.setState({selectedSubject: subject}))
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Photo A Day</h1>
        </header>

        <div>
          <ul className="category-menu">
            {this.state.categories.map(category =>
              <Category category={category} key={category.id} onClick={this.getCategory} />
            )}
            </ul>
        </div>

        {this.state.selectedCategory !== null ? (
          <div className="category-detail">
            <CategoryDetail category={this.state.selectedCategory} subject={this.state.selectedSubject} onClick={this.getSubject} />
          </div>
        ) : (
          <div></div>
        )}
      </div>
    );
  }
}

export default App;
