Received: from m239-4.eu.mailgun.net (m239-4.eu.mailgun.net [185.250.239.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917AEEED8
	for <util-linux@vger.kernel.org>; Wed, 26 Nov 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.239.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160831; cv=none; b=mUtQrNo1TAdpnQxqbfOLvTZGTgWU60W4n57+CldUSySwo1oQ4CislOhUBjWN2RIK/F9XwZmPYpJelyG1thcRq2GBFv4L2h2P1RDxusbQEVLLC01jATQnApFT/acB0/NQccjV6e/psiIiBCjQBKFyFa5EknEgTOwDlkmLSwiSNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160831; c=relaxed/simple;
	bh=eMw5ZfGz/GbRXBLaxE4P9qrErgZjDAdpQkqsqUDTe1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoElJRegnCJmL7Ok/3oClq0LPZJBM+6K3Xb8IXACvvXoDKBskI9k8cJDG9vUbxfL2VyzgiyxDNVo4uTOZ1tq0f5jRLtwfwlA0E8evaiPNNLuHhyqGc+YGEF7AFi+RiwmABXr+OL22Hzh7Oe+E7ACRWXNDAsrfZP6/jpqU/stUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=V4D33gVE; arc=none smtp.client-ip=185.250.239.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="V4D33gVE"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1764160827; x=1764168027;
 h=Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: From: From: In-Reply-To: References: MIME-Version: Sender: Sender;
 bh=QgzwzY4CM468oRAigoVmey9NWfmnaAwDVQ3XJixIoAw=;
 b=V4D33gVEko1Jpk5n6gAWutquwIRH52I+0EnBLGTifk23BAV62+j+37krmJ27W/MI+4j65nQmLcFelk2B55EhWpExIZM3FOma+UUJHAQ/NZF2k5f1mHS4iOHAJXRubct7Zo6LL6uKVauFH1XAOhW8YMuWuQRhbsiH9MsaXy4Mk2YRtsbCjtaXyLLnkuf5yfOWgBezQo0l8pMDt4P4oqOWs5FNG/SYXQUbGjj0fjN7o2ko8KfNfC1S+iRelCFBk8zU6pD3199aSaTgi8Ee3+fPssTPxotIVPl8lQFjXhiMRUtggihUkzH+s/D9Rvz6YGpVsz9xZ9IP8VN4mdlJXSrcWg==
X-Mailgun-Sid: WyJlNDM3YyIsInV0aWwtbGludXhAdmdlci5rZXJuZWwub3JnIiwiNTRlZjQiXQ==
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177]) by
 46937093e9ecc18116807af5627b7515da24d02112854031a38f33b57a6923ed with SMTP id
 6926f539ced19bbbbbc4764a (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 26 Nov 2025 12:40:25 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Sender: alessandro@0x65c.net
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787e35ab178so63708197b3.2
        for <util-linux@vger.kernel.org>; Wed, 26 Nov 2025 04:40:25 -0800 (PST)
X-Gm-Message-State: AOJu0YyAUuthn2HdVww22D1OxPHDwHNv0fW0BQVlPQ+rGACxptB3+1h6
	f+D6qWVpgY9h4lbPxHnaLG8/xK3hAqo1f9ZDjcIP80a+Zjubd2btHxO/8ZBv83TYDjXFb9Nj8sC
	PBvGqBS2bQAPO5LOm22bEKQpB3oo1RCI=
X-Google-Smtp-Source: AGHT+IHIISDrq1maGj8YSEP5zOvq/mzVLgWGYDxgPCEr7TDZek9jj95c/0cPz9FJbKGrwj1pSriYfePK9tXxwTYnQiA=
X-Received: by 2002:a05:690c:6188:b0:787:caf4:574b with SMTP id
 00721157ae682-78a8b478085mr155152767b3.6.1764160825154; Wed, 26 Nov 2025
 04:40:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123153246.1056874-1-alessandro@0x65c.net> <wrmeywniicltshcczypjo7or6hnds7wkkgaaiizbsvvzkwaab6@minsmj74e6wm>
In-Reply-To: <wrmeywniicltshcczypjo7or6hnds7wkkgaaiizbsvvzkwaab6@minsmj74e6wm>
From: Alessandro Ratti <alessandro@0x65c.net>
Date: Wed, 26 Nov 2025 13:40:14 +0100
X-Gmail-Original-Message-ID: <CAKiXHKegnt0cca+NpdA=3CiRxbiXyYZGmRVoF4Jz+wxw92cvxA@mail.gmail.com>
X-Gm-Features: AWmQ_bkhTgqIatMZhlJYOq9F--06308tBZPSzYZUhstFv9mmmFPHNdXwxekvwZE
Message-ID: <CAKiXHKegnt0cca+NpdA=3CiRxbiXyYZGmRVoF4Jz+wxw92cvxA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Consistent shell resolution across util-linux
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, thomas@t-8ch.de, 
	Alessandro Ratti <alessandroratti@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 12:51, Karel Zak <kzak@redhat.com> wrote:
>
>
>  Hi Alessandro,
>
>  thanks!
>
> On Sun, Nov 23, 2025 at 04:32:43PM +0100, Alessandro Ratti wrote:
> > This patch series addresses inconsistent default shell handling across
> > util-linux tools, which caused user-reported data loss when script(1)
> > defaulted to /bin/sh without respecting the user's configured shell.
> >
> > The series:
> > 1. Introduces ul_default_shell() for consistent shell resolution
> > 2. Updates interactive tools to use the new function
> > 3. Standardizes _PATH_BSHELL usage in security-sensitive tools
> >
> > This implements the solution discussed in:
> > https://github.com/util-linux/util-linux/issues/3865
>
> How about creating a pull request on GitHub? It will help us with the
> review, etc.

Thanks. I opened a PR on GitHub [1] as you suggested.
I=E2=80=99d be grateful for any feedback or pointers on the review.

Thank you for your time and consideration.

Best regards
Alessandro

[1]: https://github.com/util-linux/util-linux/pull/3876
