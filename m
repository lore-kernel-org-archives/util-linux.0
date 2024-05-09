Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531714AD1B
	for <util-linux@vger.kernel.org>; Thu,  9 May 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248844; cv=none; b=Hb5vmePJSGzVP9hVEXxVb1v6FqmoUOaAMCTWG2uKM5UY0etbtNPHTGGpKGmTLkgGP7ZEs2Xltunce14n1CxL3Vhzbn66lPD5Q/F80gk45AVE1kEE+QmLdQdiZ0WjW3aW+tSpRPrzF9jfjwrpynS4zlLb05lvF6VTWCs7B0P+5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248844; c=relaxed/simple;
	bh=NaRfk2dyR0SRoCMOezrUB/u113j4cieJ+8NX890PqLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HMp4IQAImv5cTKHzhuqoyU5Kd1JVURXf9V8cyjDk5Z3yUohXdGcdtw0xy6pCirIkzJi+GXrm6QJIVejaFnJnesF3Oed43YsLZueOfz6hWGFCZi4t5eBFMiYV7OIXkkajByGeit33/9FSkS98c8hZQ5uoRt5bZW6WyhoaWoAl5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViJ6uiLJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViJ6uiLJ"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ffff16400so1092129e87.2
        for <util-linux@vger.kernel.org>; Thu, 09 May 2024 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715248840; x=1715853640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CCGma3Dj10T69upf+ke4zbaLR+fLmLdW/bYdLZhj9j8=;
        b=ViJ6uiLJGlOF7lXm0QNQFxc8e7hghjwqEGGIQLoa66VTThg3e/AmcaOyeTW3YDzIHX
         MQag+OkccGhTt450Rw4IndBjx5t5WrJD3oh644wMfWp7tY9dRGzkeFKM/OE14CGW+XGE
         nl9LLBWLmKvP3C2WOmoa90cIMNihN1qTaEkgaQjHKhHorx3af0+vs9S7TXk0pKJ5o5Aq
         vm0uU2ONIYjAQXJDoJn57l7XQ81avrASBH8+Oc33SBYSZKOfoFOHILbXadtbxnM7vV2W
         /UPyfi+MPp6gY2nUBCfHWq2PreH84iGMONrDCWAgvSGNjH7xuy+HOmJfVe0zSeSVTQDr
         eNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715248840; x=1715853640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCGma3Dj10T69upf+ke4zbaLR+fLmLdW/bYdLZhj9j8=;
        b=Z0jQwF7NmHliwaFGnM+ai/mOGjSGdm3aemV85y9aBVoaRH0uMBDBDi5rwZhl6wbfOV
         zPlpQ49RKd8vle7RADPADpcmCmLIPhFDTzB9GRJ6dGvGxL9Ykwt0zRkeuEjY28tewLnQ
         47eFbk1VZ9Qm+MIhnFZykaMNNYB6HY7nqEFiJYmKT15ICbDKx8slCHxY+D5vtMM7sU4Y
         I4T7aO3mZDDEu/1goKRPJSg0pwmD8z4v4ivbJx2nuW+1g8oiTNPouGaL+1DN5Rn0m1EY
         M2rSp+2RKThoU/cZrshsfqIbVaGHnUeU7e1rzrWbqhV151rQXRbNMuQD8qt6nml5Cj0v
         AbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmFNElDEE2eoWbDr2lBfRopnJ6UyXqystSPJagnEgNWpp6NUrYSdaYKlPSixWppaVJvqdJtmvKqvQYdi0S8gtNAf0GdXZGfAXZAg==
X-Gm-Message-State: AOJu0Yw/5s9SXTg/ltUEag+FVje6CLZrXwIzaSal9k9qLPgTTU5nJevX
	F1PPvDXdfvotjuBrQ8U0jZYn856J11hP5GiDYM4rZSoh+CILkz5q
X-Google-Smtp-Source: AGHT+IFgApxaPiBdOtSF0Y+HS5ru456fTJJ6wO1teJomvk3aNKCfVadaEoDUie0MSY9NagD+ncR/yQ==
X-Received: by 2002:a05:6512:202c:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5217c5670cdmr3919532e87.16.1715248840178;
        Thu, 09 May 2024 03:00:40 -0700 (PDT)
Received: from [147.251.42.107] (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17f37sm55784466b.224.2024.05.09.03.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 03:00:39 -0700 (PDT)
Message-ID: <2cd5daa0-9b7c-409d-86e7-a2f0951bd63c@gmail.com>
Date: Thu, 9 May 2024 12:00:35 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: luks2: need to check the availability of a JSON area
To: Vitalii Hordii <vitalnodo@outlook.com>, util-linux@vger.kernel.org
References: <DBBP194MB111315092E137148D78773F3B0E52@DBBP194MB1113.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <DBBP194MB111315092E137148D78773F3B0E52@DBBP194MB1113.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 6:07 PM, Vitalii Hordii wrote:
> Hello,
> 
> I had some problems with restoring a luks2 partition after using, for
> example, mkfs.ntfs because it only leaves a 2nd JSON area without a
> secondary binary header, which I had to create myself. What if there was
> a function in libblkid that allows one to determine if there is a 2nd
> JSON and if there is a chance of recovery? Because as I see here,
> automatically repairing
> https://gitlab.com/cryptsetup/cryptsetup/-/issues/750 is apparently
> missing due to the lack of checking if there is an area here in
> libblkid. Also this seems to be a pretty popular problem on the internet
> when it comes to installing other operating systems. Would it be okay to
> add such a feature?

Hi,

Blkid already scans for *valid* 2nd LUKS2 header.

If the binary area for LUKS2 is missing, the header corrupted. Blkid
should not touch JSON metadata at all (JSON on-disk follows binary area).
Binary area was specifically designed for blkid use to be fast and do
not require any advanced metadata parsing.
So there is nothing to fix in blkid.

What we can add to cryptsetup repair command is to check
for specific case when wipefs marks LUKS2 binary area unusable
(this case can be easily recovered as it overwrites magic string only).

But I doubt mkfs format will touch only magic string, if the keyslot area
is (even partially) overwritten, the LUKS2 header is unusable anyway.

You should have a backup to recover data, not rely on a magic recovery.

Milan
