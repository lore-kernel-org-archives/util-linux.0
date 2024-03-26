Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5313CAA0
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481190; cv=none; b=FGk+c6+z4qF3auuPw1w2UvrCk4uT/9+DaS2wHKlvUgE2dPEIO+vxznHgBt9YWm9hCLtCEh1A0uDKbTE70t/RpNY6AlI5huFT3TP7CcBNfF+ivqZoF0kCfe3IMkRS2fDkn4vYuvMYhM7YoTWX0WZLioITn8RStUnE0RVqv85S2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481190; c=relaxed/simple;
	bh=y+HO1e8htm1cqK8XxFTTFz46veCom4ogeckQO7/gnXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVeDTlLupjxTbLYYVj7P02j6ZnnAzWYr098MfVPQBSpaAMzgWdlk6ivBmkKmW4xzj94gf6ywVMArEDVJlwOAiOaLMMeH21UVTo0kDjBdDAuU4bV0UnJ2rXVUVa9wNnFm+a13t2Lwoa8C5Op3cD2xoxdJYzEoTw2h24ozWzSYAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl; spf=pass smtp.mailfrom=raymakers.nl; dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b=PiqnXCE7; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raymakers.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raymakers.nl header.i=@raymakers.nl header.b="PiqnXCE7"
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4V40Cg6Wssz6g;
	Tue, 26 Mar 2024 19:26:23 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4V40Cg46BYzHS;
	Tue, 26 Mar 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=raymakers.nl header.i=@raymakers.nl header.a=rsa-sha256 header.s=soverin1 header.b=PiqnXCE7;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raymakers.nl;
	s=soverin1; t=1711481183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojeCv8g0+BTsA3xkyFBjPES3eYgVSe+B4Dkohm9ndFA=;
	b=PiqnXCE7o2w+eIxI0EB0gYXKm6WtKef4wlMECcKM4vY5PsZYMV8HhyC4gkvFx3R76XbRy+
	ZsGNga8X4y0807iI8BUilYRyf1Wq03o3g5Lu+75cHQO46IxWMASJesJd7XjA5D2gXPdeSx
	aB3QRWaaF8mSsWDbrPCfPYQfriATr3ONjsqFnhss7g45XpnPLWTLClUPmJp/3TO8LZjQHJ
	4kZpmnXpoUXPYGyRwrlIQ5Bi5C1Nvg3OXmd2kgpbMD7dxm5eJsh/qujgzUwoJMZpOcEkN4
	JeDNp7Vqzn9u0ZY9KcbYaK1duQKNs0KyeDwxbfQy4AdsIWMi6Pe8onH2rbyGjQ==
Message-ID: <c43ab992-9fb0-4b73-a542-71e4e8a86cf5@raymakers.nl>
Date: Tue, 26 Mar 2024 20:26:23 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/1] coresched: Manage core scheduling cookies for tasks
Content-Language: en-US
To: Phil Auld <pauld@redhat.com>
Cc: kzak@redhat.com, util-linux@vger.kernel.org
References: <20240326144129.GA315070@lorien.usersys.redhat.com>
 <20240326174909.117426-1-thijs@raymakers.nl>
 <20240326190910.GD315070@lorien.usersys.redhat.com>
From: Thijs Raymakers <thijs@raymakers.nl>
In-Reply-To: <20240326190910.GD315070@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Op 26-03-2024 om 20:09 schreef Phil Auld:
> I tried this version out and it doesn't work for me. One of the
> basic use cases of a wrapper like this is to run a command with
> a new cookie (say starting a container or something).
> 
> Coresched requires a pid to do that:
>  # ./coresched -n ls
>  coresched: Failed to parse PID for -n/--new: 'ls'   
> 
> With my coreset utility it does work and gives some information about what
> it did:
> 
>  # coreset -n ls
>  pid 20860's current cookie: 0x0
>  pid 20860's new cookie: 0xa9fcfbf1
>  ABOUT-NLS        chrt           configure      ionice        libsmartcols  Makefile.in
> ...
> 
> Did I miss something?  I think this will be one of the primary use cases for
> this utility.

Hi Phil,

The following command works

# ./coresched ls
chrt.1	    chrt.1.deps  coresched.1.adoc  coresched.o  ionice.1.adoc
...

By default, it will spawn the provided program with a new core
scheduling cookie.

This command
# ./coresched -n 123

is to assign a new core scheduling cookie to PID 123. The commands don't
show what the current and/or new cookie is, because that is of limited
utility in my opinion (and --get also does this). You can only use it to
check if two programs have the same cookie. An error message will be
printed and the exit code will be set if it doesn't succeed. Otherwise,
if the program succeeds then it won't write anything to stderr/stdout.

Thijs
