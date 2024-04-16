Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E99183CC1
	for <util-linux@vger.kernel.org>; Tue, 16 Apr 2024 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257846; cv=none; b=VRGI5btVKp3lWmAOZfX1IILGWVPvfGYmgBTirGJPGyPzZ4Avh9LpeVLkUl8lGBYK7w7N1blXdnDrD6F2VMtuyGLSbzkIuxjRZxRLst79HKCbXaDGyVcry/AJbvz/48zEJAt18aEtZAxBsOQvbK01f79Boglg23w+5pyzIcaij+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257846; c=relaxed/simple;
	bh=5M6urxYI8MRKwZBrXvi5NlyuoiY/ZRtrAl0oYPk5Syk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CRxSHU21lJ0M/8R7tfB86kajry4KgzyeyXQK509iwReZgo0o9SEEb5GeAyEDP24jXBVy+O6cyjKJ/v7vb8nCs3P/xkeLwtDU7vIRK1r5tnZc5qJ0kvmwA+KyPPfKqs/TaYh0WxzSN2ZczYK6nNY1lKdzMDGzACeuY954lpvxgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IQzN0cA2; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IQzN0cA2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/dQXLQg7NwIZNw5zIrJWvuExnDZmPtplIlFaxncpLsk=; t=1713257843; x=1713862643; 
	b=IQzN0cA2f9g3XbDMOZFeC53WnAqAIaSJPUAW6dqMCBt3MepmHW145NJNsx5/XU4YU/UXdCFJwPT
	ppzbJXqjE+VuypGO11rxUdTB8nE10oZe1S2XXOvZdLI3n9XdeFJ0uL4MRvfsbWNOyt+lQQ7VyESuC
	M+7/7/5CFumH5bx0E4gTrcCrYsfh4KDQiQby5nSsorKK0H2m07UsVHcuf+RuNer57r6r1BiAORlaK
	8h6cACEUoImYVdzbiTe4anO+bN30dgwf8iYGb0KSQC7HQtHqetIwtre9OSeCNMwvyX0Cnw1RlXgmF
	FIbXoaxZWwW+YD/06pYNe1uLLbW0cNFvBWnA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rwecz-00000003EZe-1A7s; Tue, 16 Apr 2024 10:57:21 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rwecz-00000002pi3-0KU3; Tue, 16 Apr 2024 10:57:21 +0200
Message-ID: <051624b9256db27a731d62c031cb627d9f5a256e.camel@physik.fu-berlin.de>
Subject: Re: lsfd/error-eperm test fails on git master
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>, Masatake YAMATO
	 <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Tue, 16 Apr 2024 10:57:20 +0200
In-Reply-To: <ed956683-5b2e-4eb5-9056-8c8eedf1c17c@t-8ch.de>
References: 
	<31ccace2e5912ffc428e065cd66764088c625c4d.camel@physik.fu-berlin.de>
	 <20240416.092958.1925095964872687612.yamato@redhat.com>
	 <873299ec-913a-43a8-ac11-20ca4b03f2f7@t-8ch.de>
	 <ed956683-5b2e-4eb5-9056-8c8eedf1c17c@t-8ch.de>
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

Hi Thomas,

On Tue, 2024-04-16 at 09:38 +0200, Thomas Wei=C3=9Fschuh wrote:
> > I can send a patch but wanted to wait for the original submitter.
>=20
> Should be fixed by https://github.com/util-linux/util-linux/pull/2960

That doesn't seem to be 100% compatible with the default awk on Debian:

  CC       lib/agetty-plymouth-ctrl.o
mawk: line 1: syntax error at or near ,
  CC       login-utils/sulogin.o

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
