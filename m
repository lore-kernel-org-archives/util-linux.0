Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0D13777E
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641832; cv=none; b=DYyiTRcx5GHiDYCbfaL+PV8v9TKuq/84ZWUeKlvzjShsRHGDjoKAPWd6FfAf1Qnzi85fm7MdbSksJ8l9OiHK4Xm5obtNbgXPRj7NBjKwehgqg3SaW0N3SXOXTOgk2qinefp10QKTyXF3ZAN7tHIrpO53NJrkEfJmG7/TCI07QjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641832; c=relaxed/simple;
	bh=FlKnkmvWEKqrz4rPFgYuFUGEEEyWLe+61qwbj/425+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL9ZjtHSXU6S34XcwD+PZiqn9At4S7NRlUNKdz065GB8JzSVNL4qfJVYuyxPs6uIl73C2NYRBHX6B5XGol3/K0SXZOZ3gcvDqsJCee6wR/v/vmiCeMJYhPoUHV7KxC6y2sGIAdq4Lp//9vDljf6m4kqJpJVBQKORnev1NfUeNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso1095040a91.1
        for <util-linux@vger.kernel.org>; Wed, 26 Feb 2025 23:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740641829; x=1741246629;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwmVLp8KZdXCMoypVESEYs1b8POaL3XDeQu9PqWX0ms=;
        b=kQdIVGnI4EjHnAL5R01Hr1r7XHZe3z89uP1n7aQVJMRhujikpRAHLTK4tgQw+runSG
         JYv3LKbBxXl4XsL7dl9LonswY8pj2GiNb4l2usaCoQbh54XSEshEy71qQUqVzRomlPac
         gRFknrP8pEqajAa3MbWr9+VoYmPpnMZmMtAURHclBs094xOV7q6UWUWujjW4MFsSsbn5
         TrNn28YDI4upv/KDSGYH+iVARjheAxLKugzCgCBpuBiX95iEgebKOQ8SMUA89gAhTOG7
         JjieLV0GUeHkkYaaU33D/beK/Yd13C0dKWHgLyCtl+qiAF+BW/A+wZlDSyVnOPPMOAPW
         YXOw==
X-Forwarded-Encrypted: i=1; AJvYcCVR5RJ2PURWPF6aGbFFPCTnYf0ksjfl6KVha+KeUP9e3A795FrQPErbKravpEtS4JBBy+PaURzCBJ0l@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwnypMi5IiTArnXRc+i06zlNo45Ur4ucf6n/At4eFnDaj2UOQ
	TITKVoJGHHgwazpzIsA06bw/ExGmjPbbPCeTO9Q65obcQLZmGUknZrBgwHaUwbXu8ew1w4VhqP4
	Qa96j7fYp2+kSiRN9EJMqjKQTEqk=
X-Gm-Gg: ASbGncscMEk+m8t5cKP4r6HSet7TF3fu9wPsKPq6VpVwdTZgrzo3o+UKnsCgaREVYm5
	t7ybSm26q66TES9YG++uKB75om1zRqsExsmEiYSX74lD/EB/rCm/aTPQY+adEh6+CN30cCO8uwg
	BVTEqNxkfQL5Za5srYQ39owaM=
X-Google-Smtp-Source: AGHT+IHtlLn02CTNfMmqvbNLLeJ8pZfUDVu+2rWRWSRYWgOlcZ+7aT8LqpbBxT4eWbNqlvUATHAtpGSCxbJWKzf422c=
X-Received: by 2002:a17:90b:3cc4:b0:2ee:ee77:227c with SMTP id
 98e67ed59e1d1-2fce868cbb8mr34554208a91.3.1740641829389; Wed, 26 Feb 2025
 23:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227044916.89925-1-joe.jin@oracle.com>
In-Reply-To: <20250227044916.89925-1-joe.jin@oracle.com>
Reply-To: kerolasa@gmail.com
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 27 Feb 2025 07:36:57 +0000
X-Gm-Features: AQ5f1Jre61VIBpkDcEBESmmEeR5MxoZ1rtn5fSyjJyVi23PgdEJ3VRy0uh43lVk
Message-ID: <CAG27Bk0tKeqnPbpuZ27aqd=2q7sx8yt263Mdq-3jock0ePymVg@mail.gmail.com>
Subject: Re: [PATCH 0/3] irqtop,lsirq: Miscellaneous enhancements
To: Joe Jin <joe.jin@oracle.com>
Cc: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 04:49, Joe Jin <joe.jin@oracle.com> wrote:
> This patchset add below new options:
>  '-b|--batch' : Batch mode
>  '-n|--number': specifies the maximum number of iterations
>  '-i|--input' : Read data from file

Thanks for contribution,

If batch mode is added the tool should also gain --json option for
structured output.

-- 
Sami Kerola
https://kerolasa.iki.fi/
