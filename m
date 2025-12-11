Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306922E0406
	for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765495485; cv=none; b=Wa0CgFrR30ynqV7098kWbHqv9d1Lp5QFee8Ec3/v+vjP8KVYquPR8N0GsOl+YoFPQc+PLw1AD1nwpJFppQkFuX4KHnbAJRpZ9iasL/XX1J+OdUO3iXFg9wEfe7jQOIPPTN9TfcICKIxI/wQu75NwXog78PzdK4u7L015wAwyI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765495485; c=relaxed/simple;
	bh=eQjT/X9FV//+zgV1KHFVDqKEzsiJNyruDNsBsBo7Fx4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FDdbFZ2wHNQocTGUFO7Mfx2XWhvD5LFJDE+Gy6HnOT0+xe2QdCPXaoZ57sGVqutGF5wP/utJUs/4OmcjHv1rC8b0y+h2TNpH0vSQMi7/aIpBcMoGdxGtC9K7+5Lh9e6tu0ARI9Eupk57ayuppTJOvJyEK4/DBeK2EfFmT/vTjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICCRzsEr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICCRzsEr"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bde0f62464cso586875a12.2
        for <util-linux@vger.kernel.org>; Thu, 11 Dec 2025 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765495481; x=1766100281; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQjT/X9FV//+zgV1KHFVDqKEzsiJNyruDNsBsBo7Fx4=;
        b=ICCRzsErUV6TQWuYXPtQkk+YclcqLDhISWCxEqLoiLUqJGyvo7dZM+Ej/z5yzVJh9Y
         F92tQ71JmYw/aJ6gEabc0650v1gAqwELRVNLxKqGeRPGJDpxtRkvGy54HWLnIbe/FBEH
         Z0f2yN8uqGwnbcItY8rs5Ksk5/2+4or9ZuVPBGan3LTQU0//S83B4mtbCYw3gS9Y2lYE
         pkyEHG1GnDrjIReffY7ReJ4Yfe+h9m6nAHj0kTuinhCe3Z2nHZdc+6KhhOtxv2o91aMu
         HHjLB5k3/s5XA9P+Mo8aqP9FSTw7SmfNdglC8ugwqNRqcddm1se2mBODqevCL4mOf9TQ
         Yd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765495481; x=1766100281;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQjT/X9FV//+zgV1KHFVDqKEzsiJNyruDNsBsBo7Fx4=;
        b=o7R+y67CvqaQpLMHc4Sg8GuUkdUBJbmBkxnTuCXvSANvL04DzXR4+W7mZTm+mwf/hj
         ZiGnBfU4qLo/nOM9jgRz6aJFRqvtSX3eaaipj5050TWiqExAZ+r0a/SoYDQXfVuIKifh
         1wvCxRkZosLe7i4DHjLpp5DPImxHgoig6hCodpToHqA59dySidWXAlW/V6JnfxKUIe84
         R2LIoCmdLBTiWNq0GNYuswsS5jSej1LNZPIrZrIhGzGfV//Ibv2mcHtLPpWkLoG2nZCS
         Kxuph0uGVfG2SSeLww//sAD6EVjYjTOLGdq0fv67+idIaS8AacU0U05heFIK+ymvY5MV
         fsJQ==
X-Gm-Message-State: AOJu0YyT/SvvZnMYUlSlceVgYQsKBTPIqOdG+Mk0rI9oCX1Yz/Qqj2Cg
	Oc4WDEfCejC7b2jmD4Ox8W96AnBBH6unHUZy/e3Ph+Gb2kRPTWF/vJWKybvgK6q2
X-Gm-Gg: AY/fxX78XVrq5KCZolggIYJ6nv1Yn7WPhfx15J6dVYmMDF6OgcLSLc5y9bmpGsGWpHw
	PPifkWQHsxK2h8v7IHyJmWDGVWidD+A3wE1AbIf1DgUQm/U0jfeUKRGVgp7kW/fn4VGwMOqsbRm
	eN8sA4isRzYLu+stIT7SrLX09R7WniPWJHI2mwOk1pYHt8a2h3/Fi1lrre9Zea9Y6JR4qN1nOIN
	ozKXJaYi16spfAMdCvukyIURJZMkS9VBFZJgjTntfWnVav/z/cq6TVhDk30GzJevVk5ZUS8Tm22
	qSQPQyh8f3Q5P4fpEg9XfWh5DNg5Na6ZJLgZbG92EUwXIxfFfd+qeRSMzN4wyBJufaub2lCbcly
	X5ZwDGeEWZlrPvEJK/RwmjP64VclwKv6utFtnuk4NXQ7TihO7p0IwsFSzPVdx+eAUJfBy/DdR3z
	sL2Fb0xsgFVOKWZ8eMTeLN0WICakWH7s/mNClurfv3rtBBznFB2OktjQ==
X-Google-Smtp-Source: AGHT+IHSWnPeMvXq6W0SHRo5uGN6DCLEnNGJYmzDBdSvkgtg87LolrLteW+0BQUSxQcsfF5THiKHxg==
X-Received: by 2002:a05:7301:7387:b0:2a7:2db:954 with SMTP id 5a478bee46e88-2ac2f8a9b81mr233518eec.15.1765495480810;
        Thu, 11 Dec 2025 15:24:40 -0800 (PST)
Received: from smtpclient.apple (decatur.viasat.com. [8.37.96.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ffae2sm9649645c88.9.2025.12.11.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 15:24:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Anthony Rossomano <trossoma2@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Partition incorrectly identified as LUKS
Date: Thu, 11 Dec 2025 15:24:29 -0800
Message-Id: <A4CF73A8-06D0-47DD-81CD-0B852DDA0F11@gmail.com>
References: <13c13750-6420-40a8-a99c-35b46b9b009a@gmail.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <13c13750-6420-40a8-a99c-35b46b9b009a@gmail.com>
To: Milan Broz <gmazyland@gmail.com>
X-Mailer: iPhone Mail (23B85)



> On Dec 11, 2025, at 1:22=E2=80=AFPM, Milan Broz <gmazyland@gmail.com> wrot=
e:
>=20
> =EF=BB=BFOn 12/11/25 4:20 PM, Anthony Rossomano wrote:
>> LUKS image is stored on XFS partition. When secondary LUKS signature
>> winds up at one of the offsets checked by libblkid partition then we
>> have the side effects of partition reported with crypto_LUKS fstype,
>> no by-label link created by udev, mount requires fstype, etc
>> Don=E2=80=99t think that this has been addressed upstream but need to
>> confirm.
> LUKS2 metadata contains offset, so it is not possible to detect
> it on a wrong offset.
>=20
> If it is detected on partition (secondary LUKS2 header),
> it probably means that partition was not properly wiped before reformat.
> (wipefs -a should wipe both LUKS2 headers)
>=20
> Anyway, without the reproducer image it is just guessing.
>=20
> Milan
>=20
Make sure we=E2=80=99re on the same page. This partition is properly wiped a=
nd formatted as XFS. There are LUKS encrypted squashfs image files stored in=
 the partition. These images are updated periodically. The issue occurs when=
 secondary LUKS signature in one of the image files winds up at offset on di=
sk checked by libblkid.=20

Tony=
