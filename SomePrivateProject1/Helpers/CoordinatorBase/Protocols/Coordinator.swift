protocol Coordinator: AnyObject {
    func start(deepLinkOption: DeepLinkOption?)
    func trigger(with deepLinkOption: DeepLinkOption)
    func triggerDependencies(with deepLinkOption: DeepLinkOption)
}
