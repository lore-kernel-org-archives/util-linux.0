Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175926A34D
	for <util-linux@vger.kernel.org>; Wed, 20 Mar 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964161; cv=none; b=exX8Zp8NZF/t0UP9P75TQMj5s/G8JP/G3rMryNE/dCmoOvRq4Wdj6+PU83PSDR/26aYmYWVLPmyiF31FNTGDtNHpASIxBNlabODMcl10n8qHrX0IC/kmfnuBkRekFr0DQXZlo+EsI2Uv4YizyXtrpZpqd7NIcfhAbsfYXmbNz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964161; c=relaxed/simple;
	bh=7xNHsbIAbHos3DuuO4wxmZgpPTAAbTLrxz+PEtIr8rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3xGZb3kv6EugVYC2ALoBhRVqybHa9F7ScGvP4gi70MkzJeHn/w4ABahhhSiFyPZlUnWqQnq6M73U+y7p5YeI5LzWuNboq6ZrPLGutd/VvOjcOBxKDSNs2VMM43ZGvcVEVGkczFTe2DBZ0BLqScwFHXVFVh6Kg9y2SN0Ij4BOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de; spf=pass smtp.mailfrom=bernhard-voelker.de; dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b=grk4cJae; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b="grk4cJae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bernhard-voelker.de; s=s1-ionos; t=1710964153; x=1711568953;
	i=mail@bernhard-voelker.de;
	bh=BnVtolgxNvULnkjEGPPfr5zaj18a8PAVNVTD79Tz0jE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=grk4cJaeFQ2UpZwdeQOvCKurmpQA06xqnRUcFgtJLJ2FuzNlEYb3Gk7ClGCRqK1j
	 O2vv2soUy2TslnV5F4YR91hK2KgXWnCJrDp9Oxtjfrx/71TSli50Jv8TjUS1mRnLH
	 jaKXBjjzXn9SP1yAtotVKvrm6fkFWrJhPYP02hkibyDbvAZ8oPN1m4a8G6JoEbjlQ
	 iaCZf41OFiLMENnSWT0sVjaoY7ulq7u42Zh7D7a7AVCe3JWEi+xnFvoIIT5Rt0LzM
	 0jpt5vFhv98LQf1lGBNb13duQwY6jhYINhl0ykg+xdyg0yjyTy/RRiBojC0vQ1byF
	 AAlR2beOHtT+lHqQ/A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.101.10] ([91.49.76.118]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2wCg-1rluqo17rY-003NaW; Wed, 20 Mar 2024 20:43:42 +0100
Message-ID: <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
Date: Wed, 20 Mar 2024 20:43:40 +0100
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
To: Paul Eggert <eggert@cs.ucla.edu>, =?UTF-8?Q?P=C3=A1draig_Brady?=
 <P@draigBrady.com>
Cc: Petr Malat <oss@malat.biz>, util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, 69532@debbugs.gnu.org,
 Karel Zak <kzak@redhat.com>, Rob Landley <rob@landley.net>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
From: Bernhard Voelker <mail@bernhard-voelker.de>
In-Reply-To: <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/DXl5kLeKeS+P9p+d2yonwdq7pkwuOyjf7QwXlr16XVyPrZ5GdX
 jPo7JJhsETtUqJWF5VAK9yrfPcFGgRVeWweTtpvPVxZ9CbfUnW/bxyEdYDpeHkr7Kv3QNir
 Wf1Fk0z6b7b7i27F6yG7XIozUbcT0DGoVNs/eRHWzsgFY4Tka8b1xiTtLx6UHgqfsfvDc2Q
 mJ7wRtloOjw/Yqd5h4msg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1sZjHFpl55w=;tle0fPIuezU+g4XFp973HRoLst5
 5+5u8EE8LSEMv505BVgQu1RhOjt0G8q+nrsN5xHj4Tr/89B3q5pUeLk7gJBRG9ClTfLePNcBs
 Bc0ktY+c0xS2knRMnJF7uHKzyFjOmi/0h7OVsGLGhu3jykbQt3uh7TTPQpuA+mEnuNru1YZax
 4YVd5q8J+lWyXPd7Yk8n+xIoNC+UWNG1Z49U4XkoqAnc4w4aDfu16fSfWipcReczm2s3W3Nqs
 ucqfTfzSxUsFTzQV9WIgjgaQbL9zPTrGlw1mDiafiG/9eQMcu8w4sIX1/tpFHGocMgO8qWRVh
 /vs5QXvpjRo6FQIZ3ARGMhb9zLMXLcHMrTLSV+nPUn8e7Qr24NLF6D4V2UJ5bg9E4BT/drTPN
 H0FrYxjEKe21Joppp6o6VChtC7ycS1GfNsuKGsyXy08VnLBfgFDZ4S2l8gDvVSfHVMTm6oM7U
 YlYaWPnLZnr0I3AM5mwb6FYuCov+agHYSB3o6Tz1vajcxsbzEqTrnWWlFEfmFiy4086CUjzFB
 nZXFJ75eYXFGLrpDu/xDp0f5pcS9AA+DRzcaDzeaj/V0APqacJlSJb2rzV/L0kE6+G0fIXaQq
 IrRZJMVlEFgjYCyYEnxzb3n0+GlJaNoRbQLXoWS+sk0AKM5gvky4zGBK4XOKEH0O9kQ3F+rnL
 6F0LXqJPabEYrdlJe2Zc4vdxzHYE0NfvhCGX6UC2yj1ZiXPzhL2LMTzZEoL4UyQxbuJqisRNI
 MC4pDo3dFVRDhsBbbiLpJuy1FBEI2k5DDTCFvGA5JyyU2Bj+va1D2M=

On 3/17/24 07:10, Paul Eggert wrote:
> Although removing that "mv --swap" implementation was a win, I don't
> think we can simply delegate this to util-linux's exch command.

I still have some headache adding this.

This stems from the fact that although mv(1) is a userland frontend
for renameat(2), the user interface is different:
while renameat(2) deals exactly with 2 operands, mv(1) has always
been able to work on more arguments.

Now, extending "exchange" to more arguments is confusing and the
use is not intuitive:
   mv -v --exchange  a b c d

An "exchange" can literally only be applied to 2 files,
and 'exch' is IMO fine.

I have the gut feeling that we didn't think through all cases,
and that some might be surprising, e.g.:

   $ mkdir d; echo 1 > a; echo 2 > d/a
   $ src/mv --exchange a a a a d/a

versus

   $ src/mv --exchange a a a a d/a

Have a nice day,
Berny

