Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B231BDC4
	for <util-linux@vger.kernel.org>; Sun, 17 Mar 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710675141; cv=none; b=i2snVWF8HYHBAInfS0TXzWPgyJpsxHnBzS854Nt10IcKEfRcA/N6pnrkGOQXCO4jg6f/LetPRol48W7ygS5KpPGlRHGesrFR8OF6OgzGA3euVHUkskRTP1ZY77FBQJmnZNVbSE0smUnAzCJXVq6Z9sMVzo7hx1rK2hyJ2g9tbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710675141; c=relaxed/simple;
	bh=VbgTgLGhBDnDnYecGr6tu/+dIxKMJcgHiuF/CJ//Ia0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6V3uQ+80Yaly6D0zJghWklIRKHA2eAFdQiwqDQwV5P7g7dueogweI9tpFSHiGT5JVUgc/SNPy3RKAJRLgq6Yq3ed2sAQY0SqMvOEgIdYN7B3tgMcmTYt2SQSs810gjbV4YsmB9pNQ5cHW1EjCVDHrMch7fbH5VJX1xp+cMm/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiXv0Qoe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiXv0Qoe"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ec8aa8b6bso2340212f8f.3
        for <util-linux@vger.kernel.org>; Sun, 17 Mar 2024 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710675137; x=1711279937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TwT7oMejggk2f25zPOj2X65KbA9c8QO1EvSH6Bdd1XE=;
        b=fiXv0Qoel4y2tnqBcLhtX1LC73foOb12SB97y1dUt/IagfxiEeeuq9DMQYZ2bje8Et
         lROzMSAJ/dvLwEd2l7y9m/nqSTSCSzhKFSJdb5xszylHHuyKlA5EV0BuLkYkiig0tmRd
         QaWEQz/RChD6YSvwy+87SOCy+SDDyHW69gqAn+JcapjD2UQHKxo6pEYHJhCxX6MAqFk/
         5/kwFYsjZRK4cjkPgiOFxL0j61GBPQ6otokpVahPxb07y1jij2n6twGYM7XvqtXisjPR
         b3VgvyASDYho6VSaG2Kkta8Cm6NJ5LWLYGtYy7LzY0WYxLSJQmWK9z/hFpIyvUeJ1BuZ
         sLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710675137; x=1711279937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwT7oMejggk2f25zPOj2X65KbA9c8QO1EvSH6Bdd1XE=;
        b=nmjOaVt3otEO9KaZnYRoEukv2Qhb2BzAc7I7zler6myLYEqTbOFww8SPj1gJLAeYh1
         Cr5jSTdxo3MeEHxp5+JjEUYeKzO5IQ0jvrEH3Nrdd8+vtSwAytW9kfWKKFXta/S7zHqe
         gusrBjSTRMZ/X4wgcAkLMQHfXt5zEJxuZgyDVE4MKR6olHpN0E8LNoQ/ruJ0L3j8c9D9
         J5hgghpsGq8rgH/xLbpWEwKw+2p+Qn0eo/2y4J5Wja2Q7fAKTHwS6t4DEFZytx6ger9j
         g4Fu1BmAon5Qc+XRCECKZ3WynHHAzWCerXHmyig/ZGlmqO3OOmVJ3Pn+co+IUtCYF9gT
         Fz+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/omn6iPF+yRv8OuE5W0CCG4b9z8q9gMwF5D1itIxgLoDMvSWKTbdBy2/WvTN+/Cxu66B2MrY9+Nw/cmdV1r6oAqfiALyBE9zgQA==
X-Gm-Message-State: AOJu0Yz/H3xMXbYe/AbH9RrUBCVqIQNcUo5pi+vkoNR8Rga1ETkzu1Qc
	jKSU2Li8/KxG3ZuJACKNsVVO143AY6h0IGZ2c0jCL/AwZnt6CRmZ
X-Google-Smtp-Source: AGHT+IFUj6mZn0pESrqZMh/4J0Se5KPDT79sp1MKNeIB0RhtIpQkveqe/bJ2u4Uu6XjwjwfpUGRYIw==
X-Received: by 2002:adf:b319:0:b0:33e:ae46:f9d with SMTP id j25-20020adfb319000000b0033eae460f9dmr3748659wrd.4.1710675136896;
        Sun, 17 Mar 2024 04:32:16 -0700 (PDT)
Received: from [192.168.1.39] (86-44-211-146-dynamic.agg2.lod.rsl-rtd.eircom.net. [86.44.211.146])
        by smtp.googlemail.com with ESMTPSA id a26-20020a5d457a000000b0033e7e9c8657sm7334063wrc.45.2024.03.17.04.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 04:32:16 -0700 (PDT)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <5308840a-9de4-33d0-2520-5f3addc9718c@draigBrady.com>
Date: Sun, 17 Mar 2024 11:32:15 +0000
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Content-Language: en-US
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: 69532@debbugs.gnu.org, Petr Malat <oss@malat.biz>,
 Rob Landley <rob@landley.net>, util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Karel Zak <kzak@redhat.com>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
From: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
In-Reply-To: <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/03/2024 06:10, Paul Eggert wrote:
> On 2024-03-05 06:16, Pádraig Brady wrote:
>> I think I'll remove the as yet unreleased mv --swap from coreutils,
>> given that
>> util-linux is as widely available as coreutils on GNU/Linux platforms.
> 
> Although removing that "mv --swap" implementation was a win, I don't
> think we can simply delegate this to util-linux's exch command.
> Exchanging files via a renameat-like call is not limited to the Linux
> kernel; it's also possible on macOS via renameatx_np with RENAME_SWAP,
> and there have been noises about adding similar things to other
> operating systems.
> 
> I just now added support for macOS renameatx_np to Gnulib, so coreutils
> does not need to worry about the macOS details; it can simply use
> renameatu with the Linux flags. See:
> 
> https://git.savannah.gnu.org/cgit/gnulib.git/commit/?id=af32ee824ee18255839f9812b8ed61aa5257a82b
> 
> Even with Linux it's dicey. People may have older util-linux installed
> and so lack the 'exch' utility; this is true for both Fedora 39 and
> Ubuntu 23.10, the current releases. Ubuntu is also odd in that it
> doesn't install all the util-linux utilities as part of the util-linux
> package, so it's not clear what they will do with 'exch'.
> 
> So I propose that we implement the idea in coreutils in a better way,
> that interacts more nicely with -t, -T, etc. Also, I suggest using the
> Linuxish name "--exchange" instead of the macOSish name "--swap", and
> (for now at least) not giving the option a single-letter equivalent as I
> expect it to be useful from scripts, not interactively.
> 
> After looking at various ways to do it I came up with the attached
> proposed patch. This should work on both GNU/Linux and macOS, if your OS
> is recent enough and the file system supports atomic exchange.

The implementation looks good.

Re exch(1) on macos, I see util-linux is on homebrew,
so it would be relatively easy to ifdef renameatx_np in util-linux also.

I think the --no-copy situation is brittle, as scripts not using it now
would be atomic, but then if we ever supported cross fs swaps
it may become non atomic. I'd at least doc with a line in the --exchange
description in usage() to say something like:
   "Use --no-copy to enforce atomic operation"

While the most flexible, it's also quite awkward to need
`mv --exchange --no-copy --no-target-directory` for most uses.
I.e. it's tempting to imply the --no-... options with --exchange,
but I suppose since scripting is the primary use case for this
flexibility trumps conciseness, so I'm ok with the verbosity I think.

thanks,
Pádraig
