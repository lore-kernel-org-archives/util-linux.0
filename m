Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222F1DF273
	for <util-linux@vger.kernel.org>; Thu, 18 Dec 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766089243; cv=none; b=SSlo1p277cjKUkmzXaAvBmHIRrM6ivK29HAhXti0Yxjr8JZegic8ZJ0Ddq4wh0Z2ZHdp4qOE5ZFqSMvFJSO1wy+IT+JRE4wlnUnFbEN3CIvhXoP8Ajza56LJtXS5jvFnGvfE8ItOJk7SZkPdr/KfR+mi5FMIkZV6057j2nVuLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766089243; c=relaxed/simple;
	bh=4cdhwXVdQBhUDwRxWobSQW4R/Hwv+cQY6tUvH5gvdDc=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=nIxNeUPNA0wYQh8JXVXoHcK4cKHdBU2bzIsm7xtH1sYaeG6IKF3dD/W3Qrd9XsgncujifWzAW5S/nUANFHwap1y+fWa1Vs5tUG/RnW+hlKPUonIzGzDf/j12na1R4p/qWqb2ZL/ZFdllvVM3dNYAGuEft2Fd3Xe0/9GuA78PADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pbarker.dev; spf=pass smtp.mailfrom=pbarker.dev; dkim=pass (2048-bit key) header.d=pbarker.dev header.i=@pbarker.dev header.b=GWl2HqKy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i24AQ6or; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pbarker.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pbarker.dev header.i=@pbarker.dev header.b="GWl2HqKy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i24AQ6or"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AFE3EC0108
	for <util-linux@vger.kernel.org>; Thu, 18 Dec 2025 15:20:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 15:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1766089238; x=1766175638; bh=FKeuEQSLUCHv1LFzsN0ZhIgA0gz6Lz8Z
	nvLvNK2ajVI=; b=GWl2HqKy8B5VhwatMs8KElbh4kePKUh/iI3ahfVkjW5vGcEr
	f5HWqZ/tANLNy35P8BOWNwi23PNhrVcF5DqsCyWHJvZy7n0NMKgvpzu85XJQxxti
	rYkustOyAHgRcwvLeIXd9SzJO7i4Aw5EqqnO1uhjOEWf02ucqJom8IqL1708ny0S
	qZ3BxOTqAGDENAcc6dQdU75LYKYNEawohZ1m8r3ig5CryM7fdcFjeqJAu3SpcZLN
	MPCqEz7PxT4EstMGZInySb4es6ABL+/zn2E+yheq+7HRuC9draN8SKM20HQau+06
	Z+nj3Cx342ami3ygvQ16dg/YcqYlw0dldDJwHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766089238; x=
	1766175638; bh=FKeuEQSLUCHv1LFzsN0ZhIgA0gz6Lz8ZnvLvNK2ajVI=; b=i
	24AQ6orCcbA9vD5Be0JxvXgCLRTT3Q74ySA9YJIbTGNHCeVuxqZAULamhUl0H55k
	ix2Xdx2T5bUfwckrd0rshnJwYtCieGynoRwRl8b6tlnHVlHshzfy56i6Blp9YCYo
	+dJwgZySXcuwkWgiLlbmhnBLYPVaPAQlwhmtNNDoqQF+sf2a6ZXNQeE5WIuv0aGz
	OcfPeYljjiICazG6TNDMgSrgbdxPEN5Fp0CjY3mykF8eXYttYJ264aIaa/cMposy
	9N5o/3wu+oW2d5+/QAGkzzGU3QakolBjv9x0qsuejr0NsVVn1+E6cs/joxXQ7Z2E
	vzr73hiNESrLYMDkb1/Og==
X-ME-Sender: <xms:FmJEaR7_D09-qxsGd1G62xworAUdo0_BZpkUeQKVkk0fWuweZTwArQ>
    <xme:FmJEaV2oTOPTP6pFIwGVafoYnFE5UR7_nCMxgRJAlNGhmonz4P6wBY8d-qbgAaO78
    EmZAN8A_RGg6Ve_ZzzXzdzjA7LjM7RI3wPXcRHM0zl7dwc3h1GFpg>
X-ME-Received: <xmr:FmJEaeGoxf7kXxDUSqnOAYNAfD0_XIZ-rvD6g4bAsESVDJCuImP-9ubwJ-yZFCeQMOFMZBY-8hUjm_MpFIjKhUq_UbHAVYjTOd8LUb1Nasn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegieefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgtfgggsehgtderredtreejne
    cuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghv
    qeenucggtffrrghtthgvrhhnpeefheegtdekteetieehjeettdeuheegveevledtfeekvd
    ehffetkeelieduveeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepud
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhtihhlqdhlihhnuhigsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FmJEafSOxEUgAO0GpBNSQ0ZgZYD6RIAzTiGQkWTVzsBg170IKl0cYg>
    <xmx:FmJEaVALNU8C76EZVHGTb19abaQqBZ3lP77OGOz7r5MFgEL0vFtp0w>
    <xmx:FmJEaf2dKvGBl34jVMjDIiBeeJ5Yd4W4xQ6ZwT25S7aYVySAQNY6Ew>
    <xmx:FmJEaTWcURN5SI18gkkg--_e41Aq4PG51GEKuQ9ol4Sg4g4gERNLbA>
    <xmx:FmJEaWaDiuiQxZEivsRY1_AAAnBLGnIY2O1Y0RBd8CfHyvxZMjeUwJqi>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <util-linux@vger.kernel.org>; Thu, 18 Dec 2025 15:20:37 -0500 (EST)
Message-ID: <978c83bdf7596879458f39f1789da016150a72d4.camel@pbarker.dev>
Subject: Inconsistent results from script test case
From: Paul Barker <paul@pbarker.dev>
To: util-linux@vger.kernel.org
Date: Thu, 18 Dec 2025 20:20:35 +0000
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-uIBO4v412Gus+43EbB2z"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-uIBO4v412Gus+43EbB2z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On the Yocto Project autobuilder we have seen occasional failures of the
util-linux test suite over the past year or so.

After investigating this, the failing test is the "size" subtest in
tests/ts/script/options. Occasionally, fewer characters than expected
are read from the pty and the test output doesn't match the expected
output.

Running the tested command in a loop locally, with heavy background load
on the CPUs, showed inconsistent results.

  for i in $(seq 0 4095); do \
    SCRIPT_TEST_SECOND_SINCE_EPOCH=3D1432489398 TZ=3DGMT \
    ../util-linux/test_script --output-limit 9 --command "echo 1:1234567890=
" test$i > /dev/null < /dev/null 2>&1 ; \
    done

This generated 3849 runs with the expected output, where there is a
blank line after the echo command output (94%):

  Script started on 2015-05-24 17:43:18+00:00 [COMMAND=3D"echo 1:1234567890=
" <not executed on terminal>]
  1:1234567890
 =20
  Script done on 2015-05-24 17:43:18+00:00 [<max output size exceeded>]

And 247 runs without the blank line (6%):

  Script started on 2015-05-24 17:43:18+00:00 [COMMAND=3D"echo 1:1234567890=
" <not executed on terminal>]
  1:1234567890
  Script done on 2015-05-24 17:43:18+00:00 [<max output size exceeded>]

This test was performed on the current HEAD of util-linux, commit
e4656fa9765f ("zramctl: Add note about column descriptions").

I see two possible ways to fix this flaky test:

1) Modify `script` to never print more characters than the requested
   output limit. This will ensure that the generated output is always
   consistent, regardless of the influence of I/O buffering.

2) Modify the test case to accept both of the above possible output
   variants.

We would like some input from folks more familiar with util-linux on
which of those options is preferred. For option (1) I should be able to
send a patch, for option (2) more invasive changes to the test framework
may be needed to allow for multiple expected outputs so I may not be
able to contribute that change myself.

Best regards,

--=20
Paul Barker


--=-uIBO4v412Gus+43EbB2z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaURiExEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bu7YAQC/RBl9YkGNaolCSheQbCgZsqxLgD4uU8NJ
UvNNjCf8LwEA+vcqdNH7vYwioyyGS/1Kw63fLoIwDC/aggqgH1Ka5Aw=
=G/AW
-----END PGP SIGNATURE-----

--=-uIBO4v412Gus+43EbB2z--
