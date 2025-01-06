Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1C78F4F
	for <util-linux@vger.kernel.org>; Mon,  6 Jan 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175760; cv=none; b=BSBU0rx7l1EFF+TZBms+G+2TjGspR4V+KjpCpXvT+uod8a/zxvszIylA6YkWtzZgl0867Cg6LXttMTbYwwIfdIwJ8hkmmZDAfGw0Aayi8fJCSNpQDLFB3WNsFBbmt70cAsfTGA2dHiJc2nmXNjhwHyjPMpfbuQVIPLSubQdNRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175760; c=relaxed/simple;
	bh=mnod9VJCyJ80FLQ97qN2o4aPQJt3MLmw2pVuMsedcFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LTueldwO5RJ2QTL57rGq9jIslXUI1gd/KA1pY6mw3ftRVb/3IBu34cZG2vu8zWtZ8uSWV1TRdqJUvuU5p4DjOeahvKI69bBXoI4aqe50SI1byOrK72ekxoYIkk+0YlT4wGph8MobSinEqM5e8L4V/dnldbT16vgcXHWHkPpSmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gL2r5Q9p; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gL2r5Q9p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W929Ngtbn5Td/kT3G4F0UAOckitFfxk2tqEGQ5FLqwA=; t=1736175756; x=1736780556; 
	b=gL2r5Q9pItqLHvrG0iyoO9aVeg4g6HiHU6wgsiHIEQi+Lu19hxtyf1fhRTA4xTdt8GQr6VX2NHk
	a+59kLGwO/4ILBqNcQ7ZO20bQsFZ2requ/lbnQX+hN5Yp3fTsPfQ+ZwYl97Khbqp6kklGU3YRM6ex
	GsyhUl1NyGnp56/shxlyIeqfIscbUpZKtP8CCDOkYhrSzVnWGosz+QdAa71Dk/xhmsnV/6r0MpkIt
	2tsZNKxFbTAZINCCtKjzk7YOzjcOq1tlwFpsebkySqqoF0BWoHNbeNZofEVewlXeePCJa8QaW71Fe
	Mx+/gi1fitcnkPs3JKeb1pUG1zJ6LDTkyMKA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tUocf-000000026km-0zZ0; Mon, 06 Jan 2025 16:02:29 +0100
Received: from p57bd9274.dip0.t-ipconnect.de ([87.189.146.116] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tUocf-00000003Lpl-05gG; Mon, 06 Jan 2025 16:02:29 +0100
Message-ID: <aa437ab7756dad03aa6b6d774acfd82e67bdbdb2.camel@physik.fu-berlin.de>
Subject: Re: v2.40.3 plan
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karel Zak <kzak@redhat.com>, Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Date: Mon, 06 Jan 2025 16:02:28 +0100
In-Reply-To: <ewc6glghupyk4koka764ymyjzuedczl4uknucujc6vlj3ohgpb@rw5jgn5dxzqe>
References: 
	<4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
	 <e0544e22-d8a3-4e13-908b-97a07cbff40b@suse.cz>
	 <ewc6glghupyk4koka764ymyjzuedczl4uknucujc6vlj3ohgpb@rw5jgn5dxzqe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Karel,

On Mon, 2025-01-06 at 15:58 +0100, Karel Zak wrote:
> Looks good, all three have been backported to the v2.40 branch.

Could you also backport these two which fix testsuite issues on alpha?

commit a0ce085c261a1d981bfa0acd4272b6ba77bfa3be
Author: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date:   Wed Dec 25 16:21:13 2024 +0100

    fincore: Use correct syscall number for cachestat on alpha
   =20
    Fixes #3331, #3333
   =20
    Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

commit 851a168e82a1264e2693acba5746ec30eee0c43b
Author: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date:   Wed Dec 25 14:08:32 2024 +0100

    tests: fdisk/bsd: Update expected output for alpha
   =20
    Fixes #3332
   =20
    Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
