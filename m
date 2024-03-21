Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2231E522
	for <util-linux@vger.kernel.org>; Wed, 20 Mar 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978869; cv=none; b=qs/yVlczzr+Rjn9npapvAWcH/2tLbspW3JL2P4Xw0YQg7K4E8wxh4dP/4pGAlTNc5D+Dfk3tFonREP0xiJnxlugaPTc74mtfz/genzp5bLHT3CR0XDYBYXZbcXYZ79g/Wy6J0xlWcuZwhminY7cgZymiPRJapUeDfSCjpV7riks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978869; c=relaxed/simple;
	bh=33CkICONktN+IgyIs0wLjya/FvBK9rbciU7WLtiKewk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuO5sIV0qxKqU74/H1EI+leGRmbvSB4Fi0sCWfEviU6W/sJwOXxRzlzXT1u4bdojl+U5yEY/RrqKPnxd+oP/9vu5xbT5Wp3WLqZYc+ZL7h0jPqoffbxMVVbymYsar4QisCz+XODkl8Uhz4cptwvOp8IBVcqyIcU4T5y6B7vao4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=3Yo5PWmX; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="3Yo5PWmX"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3662feb90a8so2700835ab.3
        for <util-linux@vger.kernel.org>; Wed, 20 Mar 2024 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1710978867; x=1711583667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NzsgalDpt3X/u2NbkXOKZFM5qtBMcfLV7J3km0Lm5k=;
        b=3Yo5PWmXb2/fKNytPfrZi2NiOfXp9W6k6pWPRMg5793s/FMJGQoyflmmlDA7Toi5In
         YPEYtmN/pnK2/3Vvs0INjps9vOepQNqD2nEqBKxm/FaY7ZtU/cGzjn3FL9dAzIiPcEMx
         BI0z17ESCV2I78mX99WSsiBKK+cuTv2Tx3475ZJupC0eMTrAxptRSHEN/V1ja9xPz/Jc
         FE48fh+R4V9ql9pdmL+HVFBUnIAEFBIoBaYguhhCyZv+4jQ9CzaR5YC0bKMgC7/yA4ev
         r4QBVkBE8qEM8MwXgdlCcNCc0sPhONyWgGh1e+/wLd6fCZY9Sh1qk3T0LXFifMv+hMZI
         19QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710978867; x=1711583667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NzsgalDpt3X/u2NbkXOKZFM5qtBMcfLV7J3km0Lm5k=;
        b=DL81aBrvtM/NLKlQMBJ3IAA34y0YtrTIzQssNeLZW94w/63YD9OM721Jij4/YCjP9J
         Y4G5FYAeqdzLeoaddle6XCO0nu0TkD1pL8AEQYpI7gz9plygmoEs0smMkMlC9I3zM1qt
         L2kNA7jEseUj1v+VWJDgXd92cEUeSBvpvDTVfmoxXJw/nKRZnG+PFenD1LnWnHoEogt2
         LX8SKJGtFNxhjZKDA5GIGQv1/tr0V80qqS//QXIriM+QhYKkafzd5PaF2Pjndd2E7+yK
         faN+LIiVX+ciZh13uqKt+6O3SdvWPqbj+gX46SUjydBse6HxZixl46Zp3HKaSLtvQgLM
         IYgw==
X-Forwarded-Encrypted: i=1; AJvYcCVpI4QYO9sxX/BcrA4PdJJdh68GhQK+sQO882D8pqqh/xry2btRGIqYhQTHj7X0B8CSTlEnmZG2YxwADIoSmGDAsoMTn7yKtEZhIA==
X-Gm-Message-State: AOJu0YxyLMJV2eISTcj1MkpDHKWYtf2XOqrsmmT8t3GwNnL42PLw8Rw5
	kYpzNBGIlrU0vouu9rkw5DkCJwcR1ovcc/9XAdKNKRqiVeTYzCBEZB+cl/lvRxEFpdECkrOIimi
	i
X-Google-Smtp-Source: AGHT+IF/5aNP6ZYnIyWJ827jffp8nmmuZOe0YE/YtulkKLljl8gLYWjzLnB4Gm3/IsEb6ueG9ZRlag==
X-Received: by 2002:a92:dd89:0:b0:367:82b5:555d with SMTP id g9-20020a92dd89000000b0036782b5555dmr394628iln.8.1710978866972;
        Wed, 20 Mar 2024 16:54:26 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id p17-20020a92c611000000b0036697c6315asm3400016ilm.87.2024.03.20.16.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 16:54:26 -0700 (PDT)
Message-ID: <5fb89ff4-74fc-7391-5dde-f6ad24132b34@landley.net>
Date: Wed, 20 Mar 2024 19:03:09 -0500
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Content-Language: en-US
To: Bernhard Voelker <mail@bernhard-voelker.de>,
 Paul Eggert <eggert@cs.ucla.edu>, =?UTF-8?Q?P=c3=a1draig_Brady?=
 <P@draigBrady.com>
Cc: Petr Malat <oss@malat.biz>, util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, 69532@debbugs.gnu.org,
 Karel Zak <kzak@redhat.com>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
 <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
From: Rob Landley <rob@landley.net>
In-Reply-To: <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/24 14:43, Bernhard Voelker wrote:
> On 3/17/24 07:10, Paul Eggert wrote:
> Now, extending "exchange" to more arguments is confusing and the
> use is not intuitive:
>    mv -v --exchange  a b c d

It's also pointless. An atomic exchange on more than 2 files ISN'T ATOMIC.
That's why I didn't do it.

You already had "mv -T" requiring exactly two arguments, so thinking mv -x has
cooties because it works the same way is just weird.

> I have the gut feeling that we didn't think through all cases,

Sounds like. Having mv modify its source directory during recursive descent is
creepy.

Toybox implemented:

-x	Atomically exchange source/dest (--swap)

Which behaves like:

  $ ./mv -x one two
  $ ./mv -x one two three
  mv: -x needs 2 args

My change from this discussion was adding the "--swap" synonym you wanted.

Rob
