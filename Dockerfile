FROM alpine:3.13 as dev
RUN apk add --no-cache gcc libc-dev make diffutils m4 emacs
WORKDIR /build
RUN wget http://ftp.gnu.org/gnu/gforth/gforth-0.7.3.tar.gz && tar xf gforth-0.7.3.tar.gz
RUN cd gforth-0.7.3 && CFLAGS='-std=gnu99' ./configure \
		--prefix=/usr/local \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--without-check
RUN cd gforth-0.7.3 && make && make install

FROM alpine:3.13 as base
RUN apk add --no-cache libgcc git
RUN adduser -S user -G users
USER user
COPY --from=dev /usr/local /usr/local
