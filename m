Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837BEC5
	for <util-linux@vger.kernel.org>; Sun,  8 Dec 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733622337; cv=none; b=ctLRPp+1iRAzimZ0d7xHmMJKTjAGqN7FEshqZ4IGj86+5VQjOO1Cq5m+xDTtj6rUQIUDdJAWjiGJwaiwNwIX28me4ywYARck9AqgNTriWp1fNbuJ60Bk6xyYq/4q/1JwAe1n2MlvatSz8rkSJz56gaivwy64/Bkn5Q1IHtQNsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733622337; c=relaxed/simple;
	bh=ObXmeD5nCzEuTv+W8dn1aOYH/xd9wbHBTE73VqaQc2s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qBQ8IqTd81ExvXJZOgUq/Qjb0gDVa5+svB4o8lD+SsK/gsUTxnzugpukDxpZTdDs18LPQwyBC5BA0MUhrpWk6ezQPvZE59OwdbRP0NMQOHDhYO6hCtNk0KdiMGlNZXMaiJUG13bB9pZwqk7LC5gtMs7YBFHNBKQRL0nCsC11MRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXGD3CUX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXGD3CUX"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4674c597f2eso5081851cf.3
        for <util-linux@vger.kernel.org>; Sat, 07 Dec 2024 17:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733622335; x=1734227135; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y12SWzJmIFJb8mhFzuDMVDoYYoPv7c2oQk6hoVyxtTI=;
        b=IXGD3CUX7dWStjNAMqCuknjYhN9/OdawL9xala/KRBbxJybxD5KpGuFjt+jC0m8KZ9
         dTUEKGVHtk2q+Bn00i2GmnwJk0VQ7lObaezheTJogagIwa8pmjax/GnFABRrE0jFygXX
         81+boKvkW/2b1XCq6RRXcGemqLVwvDmHUTp80iwCne3MBpTwh8x2wqyVaZnfISxW1icN
         Yu053CC/2aWXR0+wH6AGJNclAO9k/T2X9tY0Awg9RnK/ssRo4aBq+zBN0SnqFTKtfuLK
         5QxVEb42weubLRGXklv4nYTk36TXmNP9fIkCXDpJ3LvpyyA11Wvvn97DVNyHCYYqJUYj
         Itsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733622335; x=1734227135;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y12SWzJmIFJb8mhFzuDMVDoYYoPv7c2oQk6hoVyxtTI=;
        b=lOer+YdMdZ+r1EcH5FL0/JUzoceQyXAPD2bWyCkK1uPuhwrHKoRLuLwkXOIID0VBGu
         AuOJP5uF8Y9sjsD/wZuatTOPew/SU+iYZu7pZ6mu4nc0tkL6LNLEsbDEhqA7R0ZQXPoC
         WzhEOccMiXQQJhZl5YCDLBZLQwHkqhk0soe7rROvX4HaEhvJnGeE1JJfdQ29lEhBa+nP
         EF3Zdq9vIpwi6yjqcrd+9LaPU7qUsQK5CASM2PmC16LDwhDEV8ckZMBPUXA5TmBgZuT7
         WtZoumF/5+hnzcXhJocBz+tOjj5Kf8v4wREDqBCxvF+9dL2zqlcDiSoQyp9UzpiheOMo
         FwDg==
X-Gm-Message-State: AOJu0YwVxKpYE83Iz7woypcZ73qo0r/H8cwQURT7lS3AtInrjp7WdZjH
	RBlycQTferyQsWoXGEVlxOWk2MZgLu8YZsfGBcB7FLESr5Fy/U+DPfdiZw==
X-Gm-Gg: ASbGncvrFyIYiyX+K9f8B29YVfcjBYOyltFfRuDXyW8OJ0SdvrjtYe+xHSjhO5M9c51
	2VEvvhlOwg/2R+ZKqu1TYBhEujMWoQVmcfl24Qs5eMVswdBtlGodfmUn+n9rWdso3KFXGu2FBtJ
	Ka6HtZ02mRP9n/OfK87dRPmHB8oKaZIOBunLBCnNkm7kaG9a1c6L7F+1H5JIs+bj7nMdWoSjXyU
	RO5tix4A8RfyuXpJNvRTWNHdBphZLmPM6IcPiahq8VmPtgQH3q4
X-Google-Smtp-Source: AGHT+IEBMY4flUszeNTbACLZAF90LhT7M1G6ARHMnDUUGDnTzhbfjlm+V4jkUb7AUyztvawqNvnQYg==
X-Received: by 2002:a05:6214:529e:b0:6d4:10b0:c249 with SMTP id 6a1803df08f44-6d8e71349e1mr121323216d6.22.1733622334801;
        Sat, 07 Dec 2024 17:45:34 -0800 (PST)
Received: from [10.138.7.94] ([163.5.171.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cff6ff3esm32703885a.69.2024.12.07.17.45.33
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 17:45:34 -0800 (PST)
Message-ID: <6f939e2c-7d86-4b3d-885b-2c171c944079@gmail.com>
Date: Sat, 7 Dec 2024 20:45:32 -0500
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: util-linux@vger.kernel.org
From: Demi Marie Obenour <demiobenour@gmail.com>
Subject: Ensuring that mount(8) will always interpret a filesystem correctly
Autocrypt: addr=demiobenour@gmail.com; keydata=
 xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49yB+l2nipd
 aq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYfbWpr/si88QKgyGSV
 Z7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/UorR+FaSuVwT7rqzGrTlscnT
 DlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7MMPCJwI8JpPlBedRpe9tfVyfu3euTPLPx
 wcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9Hzx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR
 6h3nBc3eyuZ+q62HS1pJ5EvUT1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl
 5FMWo8TCniHynNXsBtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2
 Bkg1b//r6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
 9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nSm9BBff0N
 m0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQABzTxEZW1pIE1hcmll
 IE9iZW5vdXIgKGxvdmVyIG9mIGNvZGluZykgPGRlbWlvYmVub3VyQGdtYWlsLmNvbT7CwXgE
 EwECACIFAlp+A0oCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJELKItV//nCLBhr8Q
 AK/xrb4wyi71xII2hkFBpT59ObLN+32FQT7R3lbZRjVFjc6yMUjOb1H/hJVxx+yo5gsSj5LS
 9AwggioUSrcUKldfA/PKKai2mzTlUDxTcF3vKx6iMXKA6AqwAw4B57ZEJoMM6egm57TV19kz
 PMc879NV2nc6+elaKl+/kbVeD3qvBuEwsTe2Do3HAAdrfUG/j9erwIk6gha/Hp9yZlCnPTX+
 VK+xifQqt8RtMqS5R/S8z0msJMI/ajNU03kFjOpqrYziv6OZLJ5cuKb3bZU5aoaRQRDzkFIR
 6aqtFLTohTo20QywXwRa39uFaOT/0YMpNyel0kdOszFOykTEGI2u+kja35g9TkH90kkBTG+a
 EWttIht0Hy6YFmwjcAxisSakBuHnHuMSOiyRQLu43ej2+mDWgItLZ48Mu0C3IG1seeQDjEYP
 tqvyZ6bGkf2Vj+L6wLoLLIhRZxQOedqArIk/Sb2SzQYuxN44IDRt+3ZcDqsPppoKcxSyd1Ny
 2tpvjYJXlfKmOYLhTWs8nwlAlSHX/c/jz/ywwf7eSvGknToo1Y0VpRtoxMaKW1nvH0OeCSVJ
 itfRP7YbiRVc2aNqWPCSgtqHAuVraBRbAFLKh9d2rKFB3BmynTUpc1BQLJP8+D5oNyb8Ts4x
 Xd3iV/uD8JLGJfYZIR7oGWFLP4uZ3tkneDfYzsFNBFp+A0oBEAC9ynZI9LU+uJkMeEJeJyQ/
 8VFkCJQPQZEsIGzOTlPnwvVna0AS86n2Z+rK7R/usYs5iJCZ55/JISWd8xD57ue0eB47bcJv
 VqGlObI2DEG8TwaW0O0duRhDgzMEL4t1KdRAepIESBEA/iPpI4gfUbVEIEQuqdqQyO4GAe+M
 kD0Hy5JH/0qgFmbaSegNTdQg5iqYjRZ3ttiswalql1/iSyv1WYeC1OAs+2BLOAT2NEggSiVO
 txEfgewsQtCWi8H1SoirakIfo45Hz0tk/Ad9ZWh2PvOGt97Ka85o4TLJxgJJqGEnqcFUZnJJ
 riwoaRIS8N2C8/nEM53jb1sH0gYddMU3QxY7dYNLIUrRKQeNkF30dK7V6JRH7pleRlf+wQcN
 fRAIUrNlatj9TxwivQrKnC9aIFFHEy/0mAgtrQShcMRmMgVlRoOA5B8RTulRLCmkafvwuhs6
 dCxN0GNAORIVVFxjx9Vn7OqYPgwiofZ6SbEl0hgPyWBQvE85klFLZLoj7p+joDY1XNQztmfA
 rnJ9x+YV4igjWImINAZSlmEcYtd+xy3Li/8oeYDAqrsnrOjb+WvGhCykJk4urBog2LNtcyCj
 kTs7F+WeXGUo0NDhbd3Z6AyFfqeF7uJ3D5hlpX2nI9no/ugPrrTVoVZAgrrnNz0iZG2DVx46
 x913pVKHl5mlYQARAQABwsFfBBgBAgAJBQJafgNKAhsMAAoJELKItV//nCLBwNIP/AiIHE8b
 oIqReFQyaMzxq6lE4YZCZNj65B/nkDOvodSiwfwjjVVE2V3iEzxMHbgyTCGA67+Bo/d5aQGj
 gn0TPtsGzelyQHipaUzEyrsceUGWYoKXYyVWKEfyh0cDfnd9diAm3VeNqchtcMpoehETH8fr
 RHnJdBcjf112PzQSdKC6kqU0Q196c4Vp5HDOQfNiDnTf7gZSj0BraHOByy9LEDCLhQiCmr+2
 E0rW4tBtDAn2HkT9uf32ZGqJCn1O+2uVfFhGu6vPE5qkqrbSE8TG+03H8ecU2q50zgHWPdHM
 OBvy3EhzfAh2VmOSTcRK+tSUe/u3wdLRDPwv/DTzGI36Kgky9MsDC5gpIwNbOJP2G/q1wT1o
 Gkw4IXfWv2ufWiXqJ+k7HEi2N1sree7Dy9KBCqb+ca1vFhYPDJfhP75I/VnzHVssZ/rYZ9+5
 1yDoUABoNdJNSGUYl+Yh9Pw9pE3Kt4EFzUlFZWbE4xKL/NPno+z4J9aWemLLszcYz/u3XnbO
 vUSQHSrmfOzX3cV4yfmjM5lewgSstoxGyTx2M8enslgdXhPthZlDnTnOT+C+OTsh8+m5tos8
 HQjaPM01MKBiAqdPgksm1wu2DrrwUi6ChRVTUBcj6+/9IJ81H2P2gJk3Ls3AVIxIffLoY34E
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Is there a guarantee that if all data before the filesystem superblock is
zero, and that the filesystem never writes to this region, libblkid (and
thus, presumably, mount(8)) will always mount the filesystem with the
correct filesystem type, even if e.g. someone writes a file containing
a superblock of a different filesystem and the filesystem happens to put
it where that superblock is valid?

The motivation for this message is that systemd-gpt-generator generates
mountpoints based on Discoverable Partition Specification GUIDs.  These
indicate the mountpoint of the partition but not the filesystem type.
If a correctly-produced filesystem image will always continue to be
recognized as the correct type, this is fine.  Otherwise, an unlucky
combination of writes to the filesystem and filesystem allocation decisions
could cause the filesystem to start being mounted as the wrong type, which
would be very bad.  According to https://github.com/util-linux/util-linux/issues/1305,
libblkid can indeed probe for subsequent superblocks after the first one it
finds.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)

