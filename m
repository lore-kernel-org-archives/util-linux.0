Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE08C11
	for <util-linux@vger.kernel.org>; Sat, 13 Sep 2025 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757727231; cv=none; b=Kit+KZa2eFvLfK+6BuiwxpqMzi2IEBjTs7jsJrOq4foWaok8IyuaGIFxCAD0G/eWKAGg4cmbveAVGpvZAeX5s/MmhA6kwYHJFWLmMZDH/Xte7yKQqLDXfodYx0fhYoHjpCL8bzIxKsJtl3vl+Z8zgYkcrgDlXnIo8MzofMl83wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757727231; c=relaxed/simple;
	bh=95HMOZTT//eYjTYc83ZkKvscCHJWZg50zYQ04I4r+sI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZdI4szHRe+r3BpUXauouUaeoWMQMRfqDt1YRtQ46Mj+ec3jRaA19rzoDEk8NyxsHTwDKIqHsWKRdSLPNn69cgUaUk8Jn5sUOYA1BdX1+MUCocT5/HgYcSUy5Rxtn3L8Xz8a6946ZJHPSlo9oR+BoSSvguWoTI/xZeyoFlgxloj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8ZUYORh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8ZUYORh"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336af6356a5so21485811fa.3
        for <util-linux@vger.kernel.org>; Fri, 12 Sep 2025 18:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757727228; x=1758332028; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQ7KqSWWxmZe5tklGfPVtbUJarDKTyzq3Cq5rALtEsk=;
        b=L8ZUYORhC2N8RruloP8nD6ayAovD8UV0HvRtSP9g8v3ALfHKz2WvoPWnCp14vSj/WH
         Aj6BZFBjhX5qB5I5696VLHJjYlRpNpLcZIiGIFkop9DxFrxoVDM2GefCR5t7OuNNVTeL
         9lvATZdLgE8eTxzZBlymbMMJ3N2YsyFNXn8/BytFjdDRBmoJ0N63RTl9q3slyjSv8hys
         DNyuJ2gEXfxCmvPlNIDoLtGqaPQ1Ehqt4d0rXFRu7AdQUsDmBFi7ilUSwAVqyx5te3hz
         VZMq2JCYN+SHh/CT7jMXE5Z6rs6AhYuXx27pcA8MOKYh8TE/7DadsMI8Uqe4H3hFvDSc
         x7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757727228; x=1758332028;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQ7KqSWWxmZe5tklGfPVtbUJarDKTyzq3Cq5rALtEsk=;
        b=MXkK3qbszZQnws5wQJxR1n1SgCkn5mx7NciBYeYiJJrrjl8bdt0p9H9Jxw4qGPdBhF
         g99nlHJrodwTiHCsUGbfcjLYwda83moiICRgdXlgsphw9UZk+jI1TTDLP2oA5ALquRro
         ll3sktF5JW2yJ7UNHVjZzbCbZXxp0ftKlNK352O8HKW2oxcSRNhW0lAYwk2tOy4SYGUT
         WA2PlnTu4f2sHX4so08Dq6G8mz7GT63Tiowu638xCkcCZswFMY3p6kx3HnsNbBgwYwNO
         cgs3Zqq7WLmJ/EgsWQWoITrber8SNZj52moMrE9H6NMbhCEitkLj0f59aQmPuVYMBo5v
         Ahqg==
X-Gm-Message-State: AOJu0YxbRQAZzeB7vOxutdfRLusAZl/9v9lmoIGnoUTy8lcqs/KWLaoy
	NNsj9n9IphrhirLnnlHPBZLjgR54kD+w7hHhwKCnL64xGVVO8fI2HlCh4Xbj8585XN/reJPiriL
	T/XxFbMj3LirmWWk5kLJVycka+8OvabvMTkSBHAo=
X-Gm-Gg: ASbGnctqwaR+6iwo2ffS2IY4LZC1GxRzxqisW5Io3LH4iErwNhGhLwgvJc7/yj1w+Ac
	Blowv3lzbvEsjB50W4gSfT0czz6vZpchchzhevEFGkqE/5EiZHQNCsZ/3WC2HKgVtcy8FioPJwR
	9YwIhuCawSKL/xvD6a8vLQJNn8ROT6s/ZcihTQ75N4XU85EK/oftm2Ls8zDuURo8ZvGrIVEzkYs
	jS0RHOt79tdIx1YM712DOEQXDO4j+pR7nu90HZodipZSvpn
X-Google-Smtp-Source: AGHT+IG2fuQPiCH6wDw3BtZx4Tn4w+d5tXQFNHWQALrebXzzzXzUr8vgVC/MvRKL0GUpNfqgaN92oTYlfnMojH8fVzM=
X-Received: by 2002:a2e:a9a4:0:b0:336:cce2:fa5d with SMTP id
 38308e7fff4ca-3513a8ee15dmr17244821fa.11.1757727227745; Fri, 12 Sep 2025
 18:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Aplin <drtune@gmail.com>
Date: Fri, 12 Sep 2025 18:33:36 -0700
X-Gm-Features: Ac12FXyc37LvIsrO9TT1rbrM0XJFnyPhcltwOGXW1R7ytWkLhhsCmE_rPLZ4pEI
Message-ID: <CABL=7+y+5E9N1TRi1o+frURgJExQr6=qSWumc3sz=A5APkuCXg@mail.gmail.com>
Subject: Security issue : 2021 commit to libblkid breaks existing string sanitization
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi.  Apologies if my list etiquette is bad, I am noob here.

There was a 2021 commit to libblkid,
https://github.com/util-linux/util-linux/commit/6db368598962ea8b0329ae148ab878fd458f2533
commit label "Optimize the blkid_safe_string() function"

This is potentially an unsafe change and may allow shell command injection.

1. The shell command blkid has a mode "-o udev" which was designed to
output information about block devices in a LABEL=VALUE format for
consumption by shell scripts.  I have seen more than one instance (I
am looking at one now in a commercial product) where userspace script
has done:
eval $(blkid -o udev ...)

2. One of the fields returned by blkid (e.g. for a USB stick) is the
volume label, which would be controllable by an attacker inserting a
USB stick.
The blkid 'udev' command code is aware of this danger and sanitizes
the volume label and other attacker-controllable strings by calling
the function
blkid_safe_string(...)
in libblkid.
Here is the blkid code that attempts to sanitize this string, calling libblkid :
https://github.com/util-linux/util-linux/blob/b1f8b5740d81d813a2ea9ae1db8f059e5bee3b60/misc-utils/blkid.c#L280

3. In previous versions of libblkid the blkid_safe_string function
used to strip several dangerous ascii characters that would have
allowed command injection (specifically; backtick, parenthesis, etc.
It still allowed '$' which is a little dubious).

The commit 6db3685 I linked to above, dating from 2021 (which was
accepted) rewrites the ..safe_string function and now allows all
printable ascii chars from 32-127, including all shell-dangerous
characters; essentially blkid_safe_string is much less safe - in fact
downright dangerous if the "-o udev" mode output of blkid is evaluated
in a shell.

Proof of concept:
1. Format a removable USB stick (e.g. /dev/sdc1) with a VFAT volume
label e.g. "$(reboot)"
2. Run the commit listed above: "blkid -o udev -p /dev/sdc1"
3. Observe that the output of blkid has not stripped dangerous
characters and includes the line ID_FS_LABEL=$(reboot)
4. If you want to feed that output into eval or run it as a bash
script, be my guest.
5. This behavior did not happen prior to commit
6db368598962ea8b0329ae148ab878fd458f2533 -  the blkid output would be
ID_FS_LABEL=$_reboot_ this is still not ideal (the '$' was preserved
so it looks for an environment variable which can be abused to leak
information etc, ...but at least would not result in command
execution.

I suggest this commit be removed because in simple terms the
"blkid_safe_string" is now much less safe (depending on the threat
model).

Thanks,
Richard Aplin
