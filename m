Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F91D1E63
	for <util-linux@vger.kernel.org>; Tue, 19 Nov 2024 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047333; cv=none; b=IIinnPSTWKBhJ1EJkzDe1iiLteAi3XWl+og5OYS+nsjwJpY9sS8p7k27JgMObwuUWewt4IWCuxF0hY5mrTKTSdI7TswyFgkex1hDVGyqXd9U0tUSRlLdlyI27hC4WVuhqXVqUO4Omux6coT1iyUIyKJ8W1Qe/Jeovtyb9E/ryJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047333; c=relaxed/simple;
	bh=i8h+uIdXS5MdfTsZZCQPzmY4rGAp0ATnnWZjcqzeWSU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oLNHQ8zNwWf04qk0qMH5NrWlc0Oi7m7nyoQQSHr8kHUi/CqW2c3nq1i7OQiu35YW3i2iPplAbd+1xOi3JH/QKy05cqjXehZojTUzt02IR+tIH4KbGz7x1Vr6KebmN9/TuX554RgyBWadbPpOgVsBPtxNjRHZs+CyOidzGZSxPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFpMCDWH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFpMCDWH"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb51f39394so15402711fa.2
        for <util-linux@vger.kernel.org>; Tue, 19 Nov 2024 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732047329; x=1732652129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7mav41GGnpJTxz3RGrrvaccKM78YKBF76m8f87K33c0=;
        b=VFpMCDWHKlIknhJdF4XbnvY04LlkxqP6QC2cwlAfNQ4p2EIiCif9JgjSTMLMRunbMz
         lyQf0aTp+fdy9sbSsrLufuq2e4nyN2HATaPqs/eT4MDTPzAYJRU3WF0ASCqLQgw9aKTj
         YvTO6PqDdPOAc04WB1dJGde5hgi32yUK3HvrFwlo3r6akkaEC3H0TFMTsS4jpnKqy0n1
         S0bRpCOpXXvLxh/u0h6GRi/Af1poks7kI1vZx2WQUkQbZxoiVK2GzLueb9qSfViu8h8W
         eRVOdfYCjH9j/0UAUOv0t1oHYmKqQi5BFfUYO5d6g9xI3hEeFlYhj0Dio4a1sraAvxLA
         et1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732047329; x=1732652129;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mav41GGnpJTxz3RGrrvaccKM78YKBF76m8f87K33c0=;
        b=O1LdQTxSZl0ZVJ6J+YBF44qX/q0SwLKPKg9LtBvyQ3xXdXWpQ/mrW+ztJIIxrOort4
         v+DGltUqWUGF8+L5gyITXq+mGKPc/3II81ZkhAgLtP0qUfwdrvLaOBucE8WZ++FmGZ3u
         RcIL38536avl7EyC3QDDCch6HQdMdT7oLBDwW/RnPjVub99mQ2MVMaJKypKIe+Dn6bWq
         WAn0IDsdbYZGx3pGDIJWrm0+Nslp6BXTOY/Zt00qt81qR2/t+oV1tqcdR5lREiwyBN4F
         Au0S3x4LmQUb8aPYrmQApd3zOcF8NPjF7bk/GdzW4YOq18bH7nuqqUu4ayYz/Yxeru9h
         rwow==
X-Gm-Message-State: AOJu0YzSCtaFlkXxtDzy66TcNvpdxi6LfGZPKJppl//gWt5i1acsvlXl
	e9DvN5k5AOpDTeTVI2R9PCco5QwR8oD/iGIA9YFLjpPSbAYLqK1E+NLoJYtZ3hlEYn4jCrPzXgx
	I323JbItZpWpb+biWYeBRHR9X09ch1a5h
X-Google-Smtp-Source: AGHT+IFvs3n4Z+4CyOqPPrNZ7MJ1c1U3mOIwcAcrSMmLKN0fosqeJhgWI3GbVek5RVgLIhf99M/+ADuhoE8Jyfbfos8=
X-Received: by 2002:ac2:48ba:0:b0:53d:9ff9:d63 with SMTP id
 2adb3069b0e04-53dc13291e0mr6626e87.2.1732047328525; Tue, 19 Nov 2024 12:15:28
 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: anchal agarwal <mail.anchalagarwal@gmail.com>
Date: Tue, 19 Nov 2024 12:15:02 -0800
Message-ID: <CAGppiHZvn-vgiQczdTyG+F3-jwzSAMB=Kwf+jFa7UWmF_68-wQ@mail.gmail.com>
Subject: lsblk vs blkid to fetch UUID
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi,
I have a use case which involves imaging of a system using custom
scripts. Imaging involves installing an operating system and
formatting all the disks and setting up a File System.
At times I would like to enable LUKS on certain disk partitions, so I
format the partition using cryptsetup to setup luks format.
However, I had been seeing issues with fetching UUID post luksFormat
using lsblk.  I have seen the same issue with blkid but its
occurrences are exponentially less.
I want to use lsblk because its faster but seems like blkid is more
reliable here.
From what I understood from the code, blkid opens a FD for the device
and reads directly from super block; however, going through the code
of lsblk.c I see lsblk_device_get_properties() gets it from various
methods.

I am slightly confused as at that point in time the device database is
not set up so is lsblk fetching the UUID the same way as blkid does
using libblkid? Any information on this will be helpful.
Please correct me if my understanding is incorrect.


Thanks & Regards,
Anchal Agarwal
