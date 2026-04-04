func pop[T any](a []T, v *T) []T {
	n := len(a) - 1
	if v != nil {
		*v = a[n]
	}
	a[n] = *new(T)
	a = a[:n]
	return a
}
