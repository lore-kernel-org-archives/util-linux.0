Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1802C1594
	for <util-linux@vger.kernel.org>; Wed,  3 Dec 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795682; cv=none; b=WIIICUoNIKlJj5efSRf95T+WYW6lMXZEvzmabReG5aX/SJl9rS8WpzRbZvlhGrYPWqw376oFe8GhrlbVLqUFjZvrsfMr1elI9Znqtc7keOdd5ZtEpRYumgZxvsQU9Kc27vMa5T4YfmCBUAR1rsOkWuKNBr1EzU36jzVLeIwtwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795682; c=relaxed/simple;
	bh=QmShHWgawh8/P8fSASDnEVKjNd10kIM9P/7rMjg0bI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2iYkQtzPmVByb9Ve9QiP3+L3234Dp/9OLG6GdSvVLqPzrlb7PFZr8iwLPUGcUkDHVNUxZ/opAxMzNir/r2nH6Xtd1H/50Gf7EtJMk879T7XCNAv2wcwyEnEfVeHuIkc+/nK9vCWmpvYTj9XIPH7v4b3F5w1TnSMbAzoZrgcbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDZyp28/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDZyp28/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D8C4CEF5;
	Wed,  3 Dec 2025 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764795681;
	bh=QmShHWgawh8/P8fSASDnEVKjNd10kIM9P/7rMjg0bI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDZyp28/yAlOG8GE4SQqR8UyA0CyCrueMjeZcmx9C4hNJWTAkIk1Ph3jzLPJcsymZ
	 V/LC5Xo1TObzER0BRUaLfZDcg2xqqsN80XITd8dY72fa7JBW81M4GiwXPdq+udShm/
	 RltM0TpIG+UFXT/XusR2bFTQ1NtHiPrchGKJjixkZHjwbL396jMIxB5tHCd97rIqqm
	 E7ECK3fHV/JnW/KZ8l+/Tg7TFxHZMGv5g9ePTKdos+IjusJOMutYSQcMtZBJwUTe4X
	 Icm6BT5cxEIoUKnmytEZxsjelDcccnDPPlNr8lRHy+BCo5eex3HuLpXr/Hcrb/1+Md
	 z9e85h/lrIlLg==
Date: Wed, 3 Dec 2025 22:01:18 +0100
From: Alejandro Colomar <alx@kernel.org>
To: util-linux@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 0/1] Call prctl(2) with signed long integers, and
 avoid casts
Message-ID: <xfml2leih5xmokh4vhyyaarsq6ly7ehq5zfdjwwpkgnodiygwp@7tjm4lfqo6is>
References: <20240601093150.16912-1-alx@kernel.org>
 <cover.1764794880.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="egw4axiletsmmzvk"
Content-Disposition: inline
In-Reply-To: <cover.1764794880.git.alx@kernel.org>


--egw4axiletsmmzvk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: util-linux@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 0/1] Call prctl(2) with signed long integers, and
 avoid casts
Message-ID: <xfml2leih5xmokh4vhyyaarsq6ly7ehq5zfdjwwpkgnodiygwp@7tjm4lfqo6is>
References: <20240601093150.16912-1-alx@kernel.org>
 <cover.1764794880.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1764794880.git.alx@kernel.org>

Hi,

On Wed, Dec 03, 2025 at 09:50:27PM +0100, Alejandro Colomar wrote:
> Hi!
>=20
> Karel reminded me of this old patch.  Here's a revision of the patch.
> Major changes in v2:
>=20
> -  Don't specify the 5 arguments unnecessarily.
>=20
> BTW, I've developed a header file that might be useful for the general
> public.  See in a reply to this mail.

Here it is.  I think it would be useful to provide this in some libprctl
library so that everyone can use these, instead of raw prctl(2).  What
do you think?  We could start by including this header file within
util-linux, and then consider providing in a separate git repository so
that distros can package it as a system library.


Have a lovely night!
Alex

---
// Copyright 2025, Alejandro Colomar <alx@kernel.org>
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception

#include <linux/filter.h>
#include <stddef.h>
#include <stdint.h>
#include <sys/prctl.h>
#include <sys/types.h>

#if __has_include(<seccomp.h>)
# include <seccomp.h>
#endif

#if !defined(__has_c_attribute)
# define __has_c_attribute(x)  0
#endif
#if __has_attribute(__null_terminated_string_arg__)
# define LIBPRCTL_ATTR_STRING(i)  __attribute__((__null_terminated_string_a=
rg__(i)))
#endif
#if __has_attribute(__deprecated__)
# define LIBPRCTL_ATTR_DEPRECATED  __attribute__((__deprecated__))
#endif

_Static_assert(sizeof(long) =3D=3D sizeof(void *), "");
_Static_assert(sizeof(long) =3D=3D sizeof(size_t), "");

static inline int pr_cap_ambient_raise(int64_t cap) {
	return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, (long){cap}, 0L, 0L);
}
static inline int pr_cap_ambient_lower(int64_t cap) {
	return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_LOWER, (long){cap}, 0L, 0L);
}
static inline int pr_cap_ambient_is_set(int64_t cap) {
	return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET, (long){cap}, 0L,0L);
}
static inline int pr_cap_ambient_clear_all(void) {
	return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_CLEAR_ALL, 0L, 0L, 0L);
}
static inline int pr_capbset_read(int64_t cap) {
	return prctl(PR_CAPBSET_READ, (long){cap});
}
static inline int pr_capbset_drop(int64_t cap) {
	return prctl(PR_CAPBSET_DROP, (long){cap});
}
static inline int pr_set_child_subreaper(bool set) {
	return prctl(PR_SET_CHILD_SUBREAPER, (long){set});
}
static inline int pr_get_child_subreaper(bool *isset)
{
	int  ret, x;
	ret =3D prctl(PR_GET_CHILD_SUBREAPER, &x);
	*isset =3D x;
	return ret;
}
static inline int pr_set_dumpable(bool set) {
	return prctl(PR_SET_DUMPABLE, (long){set});
}
static inline int pr_get_dumpable(void) {
	return prctl(PR_GET_DUMPABLE);
}
static inline int pr_set_endian(int endianness) {
	return prctl(PR_SET_ENDIAN, (long){endianness});
}
static inline int pr_get_endian(int *endianness) {
	return prctl(PR_GET_ENDIAN, endianness);
}
static inline int pr_set_fp_mode(unsigned int mode) {
	return prctl(PR_SET_FP_MODE, (unsigned long){mode});
}
static inline int pr_get_fp_mode(void) {
	return prctl(PR_GET_FP_MODE);
}
static inline int pr_set_fpemu(int fpemu) {
	return prctl(PR_SET_FPEMU, (long){fpemu});
}
static inline int pr_get_fpemu(int *fpemu) {
	return prctl(PR_GET_FPEMU, fpemu);
}
static inline int pr_set_fpexec(int mode) {
	return prctl(PR_SET_FPEXC, (long){mode});
}
static inline int pr_get_fpexec(int *mode) {
	return prctl(PR_GET_FPEXC, mode);
}
static inline int pr_set_io_flusher(bool set) {
	return prctl(PR_SET_IO_FLUSHER, (long){set}, 0L, 0L, 0L);
}
static inline int pr_get_io_flusher(void) {
	return prctl(PR_GET_IO_FLUSHER, 0L, 0L, 0L, 0L);
}
static inline int pr_set_keepcaps(bool set) {
	return prctl(PR_SET_KEEPCAPS, (long){set});
}
static inline int pr_get_keepcaps(void) {
	return prctl(PR_GET_KEEPCAPS);
}
static inline int pr_mce_kill_clear(void) {
	return prctl(PR_MCE_KILL, PR_MCE_KILL_CLEAR, 0L, 0L, 0L);
}
static inline int pr_mce_kill_set(int policy) {
	return prctl(PR_MCE_KILL, PR_MCE_KILL_SET, (long){policy}, 0L, 0L);
}
static inline int pr_mce_kill_get(void) {
	return prctl(PR_MCE_KILL_GET, 0L, 0L, 0L, 0L);
}
static inline int pr_set_mm_start_code(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_START_CODE, addr, 0L, 0L);
}
static inline int pr_set_mm_end_code(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_END_CODE, addr, 0L, 0L);
}
static inline int pr_set_mm_start_data(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_START_DATA, addr, 0L, 0L);
}
static inline int pr_set_mm_end_data(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_END_DATA, addr, 0L, 0L);
}
static inline int pr_set_mm_start_stack(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_START_STACK, addr, 0L, 0L);
}
static inline int pr_set_mm_start_brk(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_START_BRK, addr, 0L, 0L);
}
static inline int pr_set_mm_brk(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_BRK, addr, 0L, 0L);
}
static inline int pr_set_mm_arg_start(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_ARG_START, addr, 0L, 0L);
}
static inline int pr_set_mm_arg_end(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_ARG_END, addr, 0L, 0L);
}
static inline int pr_set_mm_env_start(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_ENV_START, addr, 0L, 0L);
}
static inline int pr_set_mm_env_end(const void *addr) {
	return prctl(PR_SET_MM, PR_SET_MM_ENV_END, addr, 0L, 0L);
}
static inline int pr_set_mm_auxv(const void *addr, size_t size) {
	return prctl(PR_SET_MM, PR_SET_MM_AUXV, addr, size, 0L);
}
static inline int pr_set_mm_exe_file(int fd) {
	return prctl(PR_SET_MM, PR_SET_MM_EXE_FILE, (long){fd}, 0L, 0L);
}
static inline int pr_set_mm_map(struct prctl_mm_map *map)
{
	return prctl(PR_SET_MM, PR_SET_MM_MAP, map,
	             sizeof(struct prctl_mm_map), 0L);
}
static inline int pr_set_mm_map_size(size_t *size)
{
	int  ret, x;
	ret =3D prctl(PR_SET_MM, PR_SET_MM_MAP_SIZE, &x, 0L, 0L);
	*size =3D x;
	return ret;
}
LIBPRCTL_ATTR_STRING(3)
static inline int
pr_set_vma_anon_name(const void *addr, size_t size, const char *name)
{
	return prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, addr, size, name);
}
LIBPRCTL_ATTR_DEPRECATED
static inline int pr_mpx_enable_management(void) {
	return prctl(PR_MPX_ENABLE_MANAGEMENT, 0L, 0L, 0L, 0L);
}
LIBPRCTL_ATTR_DEPRECATED
static inline int pr_mpx_disable_management(void) {
	return prctl(PR_MPX_DISABLE_MANAGEMENT, 0L, 0L, 0L, 0L);
}
LIBPRCTL_ATTR_STRING(1)
static inline int pr_set_name(const char *name) {
	return prctl(PR_SET_NAME, name);
}
LIBPRCTL_ATTR_STRING(1)
static inline int pr_get_name(char name[16]) {
	return prctl(PR_GET_NAME, name);
}
static inline int pr_set_no_new_privs(void) {
	return prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, 0L, 0L);
}
static inline int pr_get_no_new_privs(void) {
	return prctl(PR_GET_NO_NEW_PRIVS, 0L, 0L, 0L, 0L);
}
static inline int pr_pac_reset_keys(unsigned long keys) {
	return prctl(PR_PAC_RESET_KEYS, keys, 0L, 0L, 0L);
}
static inline int pr_set_pdeathsig(int sig) {
	return prctl(PR_SET_PDEATHSIG, (long){sig});
}
static inline int pr_get_pdeathsig(int *sig) {
	return prctl(PR_GET_PDEATHSIG, sig);
}
static inline int pr_set_ptracer(pid_t pid) {
	return prctl(PR_SET_PTRACER, (long){pid});
}
#if __has_include(<seccomp.h>)
LIBPRCTL_ATTR_DEPRECATED
static inline int pr_set_seccomp_mode_strict(void) {
	return prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT);
}
LIBPRCTL_ATTR_DEPRECATED
static inline int pr_set_seccomp_mode_filter(const struct sock_fprog *filte=
r) {
	return prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, filter);
}
#endif
static inline int pr_get_seccomp(void) {
	return prctl(PR_GET_SECCOMP);
}
static inline int pr_set_securebits(unsigned int securebits) {
	return prctl(PR_SET_SECUREBITS, (unsigned long){securebits});
}
static inline int pr_get_securebits(void) {
	return prctl(PR_GET_SECUREBITS);
}
static inline int pr_get_speculation_ctrl(long misfeature) {
	return prctl(PR_GET_SPECULATION_CTRL, misfeature, 0L, 0L, 0L);
}
static inline int pr_set_speculation_ctrl(long misfeature, int ctrl) {
	return prctl(PR_SET_SPECULATION_CTRL, misfeature, (long){ctrl}, 0L, 0L);
}
static inline int pr_sve_set_vl(unsigned long val) {
	return prctl(PR_SVE_SET_VL, val);
}
static inline int pr_sve_get_vl(void) {
	return prctl(PR_SVE_GET_VL);
}
static inline int pr_sys_dispatch_on(size_t off, size_t size, int8_t *sw)
{
	return prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON,
	             off, size, sw);
}
static inline int pr_sys_dispatch_off(void) {
	return prctl(PR_SET_SYSCALL_USER_DISPATCH,PR_SYS_DISPATCH_OFF,0L,0L,0L);
}
static inline int pr_set_tagged_addr_ctrl(int mode) {
	return prctl(PR_SET_TAGGED_ADDR_CTRL, (long){mode}, 0L, 0L, 0L);
}
static inline int pr_get_tagged_addr_ctrl(void) {
	return prctl(PR_GET_TAGGED_ADDR_CTRL, 0L, 0L, 0L, 0L);
}
static inline int pr_task_perf_events_enable(void) {
	return prctl(PR_TASK_PERF_EVENTS_ENABLE);
}
static inline int pr_task_perf_events_disable(void) {
	return prctl(PR_TASK_PERF_EVENTS_DISABLE);
}
static inline int pr_set_thp_disable(bool set, unsigned int flags)
{
	return prctl(PR_SET_THP_DISABLE, (long){set},
	             (unsigned long){flags}, 0L, 0L);
}
static inline int pr_get_thp_disable(void) {
	return prctl(PR_GET_THP_DISABLE, 0L, 0L, 0L, 0L);
}
static inline int pr_get_tid_address(int **addrp) {
	return prctl(PR_GET_TID_ADDRESS, addrp);
}
static inline int pr_set_timerslack(unsigned int slack) {
	return prctl(PR_SET_TIMERSLACK, (unsigned long){slack});
}
static inline int pr_get_timerslack(void) {
	return prctl(PR_GET_TIMERSLACK);
}
static inline int pr_set_timing(int mode) {
	return prctl(PR_SET_TIMING, (long){mode});
}
static inline int pr_get_timing(void) {
	return prctl(PR_GET_TIMING);
}
static inline int pr_set_tsc(int mode) {
	return prctl(PR_SET_TSC, (long){mode});
}
static inline int pr_get_tsc(int *mode) {
	return prctl(PR_GET_TSC, mode);
}
static inline int pr_set_unalign(unsigned int bits) {
	return prctl(PR_SET_UNALIGN, (long){bits});
}
static inline int pr_get_unalign(unsigned int *bits) {
	return prctl(PR_GET_UNALIGN, bits);
}
static inline int pr_get_auxv(void *auxv, size_t size) {
	return prctl(PR_GET_AUXV, auxv, size, 0L, 0L);
}
static inline int pr_set_mdwe(unsigned int mask) {
	return prctl(PR_SET_MDWE, mask, 0L, 0L, 0L);
}
static inline int pr_get_mdwe(void) {
	return prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
}
static inline int pr_riscv_set_icache_flush_ctx(int ctx, int scope) {
	return prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, (long){ctx}, (long){scope});
}
static inline int pr_futex_hash_get_slots(void) {
	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
}
static inline int pr_futex_hash_set_slots(size_t size) {
	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, size, 0L);
}


--=20
<https://www.alejandro-colomar.es>

--egw4axiletsmmzvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkwpRgACgkQ64mZXMKQ
wqkmaw/9G/2BwlXycyJ2GiPKQ7eT088zHIw8wv4OFqXjhIADX249LN2/yyIApy80
1tWNTbjr6yFPIEE1WAJxHQOo2GhjOxQG4PKXuGsAxnll7VVUug6NGSnHC7SrammU
pxiXsRFEBzzSIo2IY6Oyr77ZiL3FoM1ZwJKrdzFoNd2xMulHtBweRzJAHKwze5lN
oDs+B3oHktwjguUd6w+8fS5m13HwnekVk4AVmsaNT9VH/eioYP72LZztbaQbz5KP
4ZHqO4AqnAy8uN44M5BUILU4+nEEypSgw5MMM8IViGv+P4f1FY+JvjdBO3MwDB/7
ZEZsCn46NwKHJn7VoBi1sGdUSyvYIc0UDYIhE9VhBa4mrEneNNvWs4Htaq/UvjeB
GPHthXrp9wCrm5TrqmXcuDz1UpsY0GCmCuMnuKOR7sBxpo+CStEzf9giOdowgp/N
qwIeSPDHMqP29A2Nib7f0beLcuTd0stOcnpPTU/hj2o2CZrMcYTqbP0F2PB6VWoJ
rrMm9v05yPtjlh7jb+P7mSBxhHJI+D4zcSn3GVM2+6nODUY4+/sWwJCTzKP0YyQj
WRuxMHdZDa8Tn+5h9ixL9VHk7xD2glk5uLAfuRutCxZ3uATnfXUHBzfLfih4benS
aAwrP8ACeSYp0bPYNy4zhHGN1qCPTZXrNflbzm0FwO2fXJAUKu0=
=QIF0
-----END PGP SIGNATURE-----

--egw4axiletsmmzvk--
