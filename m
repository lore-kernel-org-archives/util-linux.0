Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F21EA74
	for <util-linux@vger.kernel.org>; Tue,  9 Apr 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652282; cv=none; b=BHd+nxtetisFcza8TSeZwTAmPoHLHmeye/UEaNXkmYWm3B9iL6IYcr0WvKy31ht5eYB/2gdwWVSgKXM7hIrWFOufNb0ME3svduz6i86O/M3LNuTb83ih8UTsIKLDb45JXnZFyHWJxbARhzYXWSB0V3bJhdkbe5SGa83zI5TkmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652282; c=relaxed/simple;
	bh=Y2lafVkYPFVz4tpur5zrPp0lIL1kKpqLpeGwq/Vl2hw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tzZk1EgquyPgDfDAsy+lxxhXj93SemJCVWmjtN1r5AkI6dAlgl6P5lOOsAMHKoUDJYZ1y6eEH0PkGSlWA/zxRPwwVqJtLkx4Sz0DoGYObwA7oL3h0ve50ObAVtxkY9BrY9i39iU8OvEDo7wNLpMOr2WRN3ix4Iho48ZVuGAsLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=jODE4gYy; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="jODE4gYy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0XAp7yXda318xwAmHiHN12UjJJbu9+56Fy0KIdO5Q2g=; t=1712652279; x=1713257079; 
	b=jODE4gYy240s5WVoCvMJD/ibXhxEkFFDJtjCESpvw4XxWrRBkgul+mm0+ZpSjq6FBxkV9WpPLL1
	vbH0ictIeGWc1ms5PNDRECAveEMh96vQ7975QnYfTHgOPzYS+QJIPcZeT3ToMRSKLfqMT2IROzFdf
	4u0CYZlhQ2z2zdD5BU2sbZqpmYR/Ery8p4UrISq15ZNjzI69Ih6h4NTfZbi22juZv5tfKDu1FCpSu
	TF+X2wPzRJ8w6pSuQjw5B6UOuJJOHCM+SsPOwaknzn+cLQ4zPaNC2sv0ZJsAjsvAZyRGTf+FKuV1E
	twr/84MOp0gV96xnv4L4J2K77jv4UGPI5fCw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ru75p-00000003XLD-176T; Tue, 09 Apr 2024 10:44:37 +0200
Received: from p5dc55805.dip0.t-ipconnect.de ([93.197.88.5] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ru75p-000000031to-0HL1; Tue, 09 Apr 2024 10:44:37 +0200
Message-ID: <4893cfc0e924f1b160f9d690b93227cd28320624.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] audit-arch.h: add defines for m68k, sh
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Date: Tue, 09 Apr 2024 10:44:36 +0200
In-Reply-To: <20240409083459.346888-1-zeha@debian.org>
References: <20240409083459.346888-1-zeha@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Tue, 2024-04-09 at 10:34 +0200, Chris Hofstaedtler wrote:
> John Paul Adrian Glaubitz points out that libseccomp needs to release 2.6=
.0,
> too.

Indeed ;-).

> Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
> ---
>  include/audit-arch.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/include/audit-arch.h b/include/audit-arch.h
> index ade182417..9afc663cd 100644
> --- a/include/audit-arch.h
> +++ b/include/audit-arch.h
> @@ -35,6 +35,8 @@
>  #    endif
>  #elif __powerpc__
>  #    define SECCOMP_ARCH_NATIVE AUDIT_ARCH_PPC
> +#elif __m68k__
> +#    define SECCOMP_ARCH_NATIVE AUDIT_ARCH_M68K
>  #elif __mips__
>  #    if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
>  # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_MIPS
> @@ -47,6 +49,12 @@
>  #    else
>  # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_ARCV2
>  #    endif
> +#elif __sh__
> +#    if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> +# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SH
> +#    else
> +# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SHEL
> +#    endif
>  #elif __sparc__
>  #    if __SIZEOF_POINTER__ =3D=3D 4
>  # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SPARC

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
