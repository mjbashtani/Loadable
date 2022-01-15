# Loadable
A generic state manager

Loadable is a simple state manager that helps you to better handle asynchronous operations

[![CI](https://github.com/mjbashtani/Loadable/actions/workflows/CI.yml/badge.svg)](https://github.com/mjbashtani/Loadable/actions/workflows/CI.yml)

## How it works

You can deliver your publisher events to a publisher with Loadable output type


```swift
@Published var data: Loadable<Data> = .idle
  
func fetchData() {
    service
        .getSomeData()
        .mapToLoadable()
        .assign(to: &$data)
}
```
  

