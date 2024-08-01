Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D728143727
	for <util-linux@vger.kernel.org>; Thu,  1 Aug 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536206; cv=none; b=JEkB4F0gC1w/ytVXiadCo5/W+l34chi+uX47SGK6Jb+ReD3EZTMxeM2kQL3QZREAC3hGt9lZV4lT4rKDFN3DaXGp6H4vKIeGXgoz6SOOpE4ZGTcHWLof5PQNXhr4o0IBT7tQfP1y4qxc7CslrRdEUqWEm7oLYJdhEBkv7FNxQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536206; c=relaxed/simple;
	bh=N4VXe06egoYwAT0D2cVXnPhHIY42P5/A9OEpdjtC7Hw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=stpqJnFTY9OgUuX9HaFxtBKv2tpzLJlthrMXo+s1YIrYO8TQsLuNcmfvsOMzVxwDqa1zOCMxI+8LKfRBjVxuJsH3G1V8t4hbF5KeUUa5ZbCtu9gk+xcj/bmYTI/fM1fvnKQs+f3LwGws4ldu67H4fON5AqcanONV8sD9wEMAzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqJmATPk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqJmATPk"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a975fb47eso1017856166b.3
        for <util-linux@vger.kernel.org>; Thu, 01 Aug 2024 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722536202; x=1723141002; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ugGVXVv0vHm5X/Z4MFjDF+pl+sq+XszDAddM5kLqJSE=;
        b=GqJmATPkMOFYUZp5rZjTEDg49ThkPTHGQFyyEeFgJHMMYjfekf8HPEXzxwwoLIY4ux
         hMwp3+MeMlJS7/ppfQ1FQSOnd3gkWRaVaVXioK8lsPrSxLGh3NMhY3T8mIHN93U/y8ta
         oh0vfXrLKJt2mPVOGu/LizzvytBHC5zqlSgVA0Zeim8hUyUeYfOBnamDfwvL5MVwOrcX
         Tz6WJzfOOjKt5mcYjCV1h0wDB3H9uxGibedOOsDXpDADnCfDB1iZCP9ANNH4QW0xsWXn
         EGNwtxjue/mADmE5uqLDz+ts2m/DL6Wr5zHP9D0J/ZKBZjkgs/jsI9EtuxzzH0Ii1rCT
         SpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722536203; x=1723141003;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugGVXVv0vHm5X/Z4MFjDF+pl+sq+XszDAddM5kLqJSE=;
        b=OJ9ngFLRBYZJgkq1AmNnTK7raX9L0YDPchH7KXXlmvfeuRFqxSTGV38oFSM83rp+Pz
         tlSsbHpobGvbOypDuS0bxcAtt9pdIyOJ9Dxv5hQ5V8KSzg5gwgduFeCkAWfaxBSfAS7I
         wDEHzbZ4bcWMRZB+ZmR2ijWDiNFMDO69R6QAF2jE5L/nTe0jYYe9EFs86S/e4sSCZF2j
         FUgSTbXeK/HUhnhXXkwEm6pOuKnpmrV4y3yW67BoEvYpvUbmxFgkys6gkV0Qzckanchs
         T6TIodYdNysOd0uqdgpAX0Q8mXaQKeFXrgTkOIvVQHM75Ul2r9oOUYq8DnjO7+Xp0UTk
         CSrQ==
X-Gm-Message-State: AOJu0Ywq/F46547qgLG1Tt81Is2rI4qrE4EJYkWrWkE/LwwaaoJvqDfs
	W8h+dMcgzfFZvQJahWukwuCAUSIaH+zz/OghNjPzhDtfeyf0roBCE0YDFtVhF0W3+3X5nIUyDqg
	k5SaTOsEB0BniGnA7swQ1lEEJqt+gWincwpE=
X-Google-Smtp-Source: AGHT+IEJp44sn9OCuqCmFTpBkVqRB5OHMDM6jhh/F0TusUXbBzP+n0Tx1sjuy5YiZbUxxnCaoNHPkQOJSyOFScE1YH4=
X-Received: by 2002:a17:907:3f9c:b0:a7a:b43e:86d4 with SMTP id
 a640c23a62f3a-a7dc4de2af4mr73523666b.15.1722536202187; Thu, 01 Aug 2024
 11:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Rinehart <johnrichardrinehart@gmail.com>
Date: Thu, 1 Aug 2024 11:16:30 -0700
Message-ID: <CAGc5Yo9G2mJkbgVAbZESVvBVCK9OF7MWbEf=Mt0tY2XBFg+=yQ@mail.gmail.com>
Subject: fuse mount failure when type contains '.'
To: util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000071e374061ea3369f"

--00000000000071e374061ea3369f
Content-Type: multipart/alternative; boundary="00000000000071e371061ea3369d"

--00000000000071e371061ea3369d
Content-Type: text/plain; charset="UTF-8"

`util-linux` seems to fail to handle a use case that users like me seem to
be hitting with some frequency. The issue is around
https://github.com/util-linux/util-linux/blob/86b6684e7a215a0608bd130371bd7b3faae67aca/libmount/src/context.c#L2115-L2121
and seems rooted in the fact that `util-linux` operates on `type` where
type is always of the form <a>.<b> but where <b> is apparently assumed to
not contain Unicode U+002E (ASCII 2E): '.' ("dotless"). I say it "appears
to assume" this since the logic which appears to remove the subtype does so
by using `strrchr`, which addresses only the last period in the `helper`
string. If the `subtype`, itself, has a U+002E character then this won't
remove the subtype.

As an example, if `helper` looks like
`path/name.type./subtype/path/with/a.period` then the modified `helper`
after `strrchr` will look like `path/name.type./subtype/path/with/a`
instead of the apparently-intended `path/name.type`.

This crops up for users like me because  I use NixOS which is a store-based
Linux operating system using paths like:
```
$ readlink -f $(which s3fs)

/nix/store/xwbx0fbg65ml2qjl86p9p2w58kghqn8r-s3fs-fuse-1.94/bin/s3fs
```
(So, paths like `/nix/store/<hash>-<name>-<version>/bin/<cmd>`). `version`
is usually a dot-delimited string like `1.23`.

I've generated a patch which seems to ameliorate this behavior. It's
attached (sorry if attachments are not the way to go with this mailing
list, specifically, or mailing lists, generally - this is my first time
submitting a patch to a mailing list). The logic is simple, but it
basically iterates through all possible substrings according to the number
of U+002E characters in the `type` string. It's a more generic form of the
logic already present, but it's a little heavy-handed. Happy with any and
all changes which preserve the apparently-corrected behavior.

Please let me know if I should make any changes or if a change like this
won't be accepted for some reason or if I'm misunderstanding the
problem/solution.

Thank you!

Cf.
1. https://discourse.nixos.org/t/how-to-setup-s3fs-mount/6283/5
2. https://github.com/NixOS/nixpkgs/issues/46529#issuecomment-655536831

-- John Rinehart

--00000000000071e371061ea3369d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">`util-linux` seems to fail to handle a use case that users=
=C2=A0like me seem to be hitting with some frequency. The issue is around=
=C2=A0<a href=3D"https://github.com/util-linux/util-linux/blob/86b6684e7a21=
5a0608bd130371bd7b3faae67aca/libmount/src/context.c#L2115-L2121">https://gi=
thub.com/util-linux/util-linux/blob/86b6684e7a215a0608bd130371bd7b3faae67ac=
a/libmount/src/context.c#L2115-L2121</a> and seems rooted in the fact that =
`util-linux` operates on `type` where type is always of the form &lt;a&gt;.=
&lt;b&gt; but where &lt;b&gt; is apparently assumed to not contain Unicode =
U+002E (ASCII 2E): &#39;.&#39; (&quot;dotless&quot;). I say it &quot;appear=
s to assume&quot;=C2=A0this since the logic which appears to remove the sub=
type does so by using `strrchr`, which addresses only the last period in th=
e `helper` string. If the `subtype`, itself, has a U+002E character then th=
is won&#39;t remove the subtype.<br><br>As an example, if `helper` looks li=
ke `path/name.type./subtype/path/with/a.period` then the modified `helper` =
after `strrchr` will look like `path/name.type./subtype/path/with/a` instea=
d of the apparently-intended `path/name.type`.<br>=C2=A0=C2=A0<br>This crop=
s up for users like me because=C2=A0 I use NixOS which is a store-based Lin=
ux operating system using paths like:<br>```<br>$ readlink -f $(which s3fs)=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>/nix/store/xwbx0fbg65ml2qjl86p9p2w58kghqn8r-s3fs-fuse-1.94/bin/s3fs<=
br>```<br>(So, paths like `/nix/store/&lt;hash&gt;-&lt;name&gt;-&lt;version=
&gt;/bin/&lt;cmd&gt;`). `version` is usually=C2=A0a dot-delimited string li=
ke `1.23`.<br><br>I&#39;ve generated a patch which seems to ameliorate this=
 behavior. It&#39;s attached (sorry if attachments are not the way to go wi=
th this mailing list, specifically, or mailing lists, generally - this is m=
y first time submitting a patch to a mailing list). The logic is simple, bu=
t it basically iterates through all possible substrings according to the nu=
mber of U+002E characters in the `type` string. It&#39;s a more generic for=
m of the logic already present, but it&#39;s a little heavy-handed. Happy w=
ith any and all changes which preserve the apparently-corrected behavior.<b=
r><br>Please let me know if I should make any changes or if a change like t=
his won&#39;t be accepted for some reason or if I&#39;m misunderstanding th=
e problem/solution.<br><br>Thank you!<br><br>Cf.<br>1.=C2=A0<a href=3D"http=
s://discourse.nixos.org/t/how-to-setup-s3fs-mount/6283/5">https://discourse=
.nixos.org/t/how-to-setup-s3fs-mount/6283/5</a><br>2.=C2=A0<a href=3D"https=
://github.com/NixOS/nixpkgs/issues/46529#issuecomment-655536831">https://gi=
thub.com/NixOS/nixpkgs/issues/46529#issuecomment-655536831</a><br><br clear=
=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">-- John Rinehart</d=
iv></div></div></div></div></div>

--00000000000071e371061ea3369d--
--00000000000071e374061ea3369f
Content-Type: text/x-patch; charset="US-ASCII"; name="util-linux.patch"
Content-Disposition: attachment; filename="util-linux.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lzblil8m0>
X-Attachment-Id: f_lzblil8m0

ZGlmZiAtLWdpdCBhL2xpYm1vdW50L3NyYy9jb250ZXh0LmMgYi9saWJtb3VudC9zcmMvY29udGV4
dC5jCmluZGV4IGQzOGUzNjcxZi4uNDExZjk4ZjNmIDEwMDY0NAotLS0gYS9saWJtb3VudC9zcmMv
Y29udGV4dC5jCisrKyBiL2xpYm1vdW50L3NyYy9jb250ZXh0LmMKQEAgLTIwOTcsNiArMjA5Nywx
MSBAQCBpbnQgbW50X2NvbnRleHRfcHJlcGFyZV9oZWxwZXIoc3RydWN0IGxpYm1udF9jb250ZXh0
ICpjeHQsIGNvbnN0IGNoYXIgKm5hbWUsCiAJaWYgKCFuc19vbGQpCiAJCXJldHVybiAtTU5UX0VS
Ul9OQU1FU1BBQ0U7CiAKKwkvKiBSZWNvcmQgbnVtYmVyIG9mICcuJyBpbiBgdHlwZWAgc28gd2Ug
Y2FuIHRyeSBhIGZldyB0aGluZ3MgbGF0ZXIuICovCisJaW50IGRvdF9jb3VudCA9IDA7CisJZm9y
IChpbnQgaT0wOyB0eXBlW2ldOyBpKyspCisJCWRvdF9jb3VudCArPSAodHlwZVtpXSA9PSAnLicp
OworCiAJLyogSWdub3JlIGVycm9ycyB3aGVuIHNlYXJjaCBpbiAkUEFUSCBhbmQgZG8gbm90IG1v
ZGlmeSBAcmMKIAkgKi8KIAlwYXRoID0gc3RydG9rX3Ioc2VhcmNoX3BhdGgsICI6IiwgJnApOwpA
QCAtMjExMiw4ICsyMTE3LDggQEAgaW50IG1udF9jb250ZXh0X3ByZXBhcmVfaGVscGVyKHN0cnVj
dCBsaWJtbnRfY29udGV4dCAqY3h0LCBjb25zdCBjaGFyICpuYW1lLAogCQkJY29udGludWU7CiAK
IAkJZm91bmQgPSBtbnRfaXNfcGF0aChoZWxwZXIpOwotCQlpZiAoIWZvdW5kICYmIHN0cmNocih0
eXBlLCAnLicpKSB7Ci0JCQkvKiBJZiB0eXBlIGVuZHMgd2l0aCAiLnN1YnR5cGUiIHRyeSB3aXRo
b3V0IGl0ICovCisJCS8qIElmIHR5cGUgY29udGFpbnMgJy4nIHRoZW4gdHJ5IHdpdGhvdXQgdGhl
bS4gKi8KKwkJZm9yIChpbnQgY250ID0gZG90X2NvdW50OyAhZm91bmQgJiYgY250OyAtLWNudCkg
ewogCQkJY2hhciAqaHMgPSBzdHJyY2hyKGhlbHBlciwgJy4nKTsKIAkJCWlmIChocykKIAkJCQkq
aHMgPSAnXDAnOwo=
--00000000000071e374061ea3369f--
