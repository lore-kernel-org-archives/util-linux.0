Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB971C9EC9
	for <util-linux@vger.kernel.org>; Tue,  1 Oct 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797609; cv=none; b=aPeu1JFC+c8+pwz4YEsZ6RkLEECevLLgRb4JL8gUzqdv96NUUVTdXe1IoNOjDTJZqndgCT/qUo4u+iZ/9Mw2Bf2uzI3JzKW1jIoX8oNlT1dD0STf4L+TIajPuhchdTMhq0PSvE0RC1YnRvV2kvpzTpJ3cs98em2fppt9TfGKwCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797609; c=relaxed/simple;
	bh=ff8TIA+ZnUnM9M9foHpnS3Bqo+eKDhL5gPfwXr71hxg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=a76WCP/OEM56umUPQdoYSouVkO5Ma1+ffK489GRFjjxm7Ec7+S5LnGbivWn5qM4zLTs1xf7ePhzDhrEZuZvLv3QIaV3KhkHGX9DM3A+iN6ZAJFyeuP1XegBoVmL6jXjwUFHpfKf6j3uOpgeF62WftV9Gt1cIP07XTUu9yPvVqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTN1Kdrj; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTN1Kdrj"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e28ac7b12bso3152284b6e.3
        for <util-linux@vger.kernel.org>; Tue, 01 Oct 2024 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727797607; x=1728402407; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9USttcl8aLKB8K6r98GA8UU336npTclncTsz3/BjB4=;
        b=BTN1Kdrj0/iBsRs3IUpvueBmofglt9VNMZl5/Y57fR932NrbasyFiV43UHW/TODzm6
         je8nt91A0pGU1UWDtiuzIzt5TP9M8+yLQoyairEhsvcINbMX73SIIXvR3Qy7ZiMS92we
         m3sLN9hz3vdH48M3b01zI7VAGCH1YNNNpSdOM50wk8CPpuiUf3Fu717Z52sb9rBB8G0b
         d28skn8C7bbS9C2k1QCjBmQddwCn/ZB/JQwm7fovHKCrrrPaIQeZgUW4KsiDgsyTUpmF
         EW/0+tykQ/bmIseJPdwjYF3YctDujxx2/xWdLhtB3kMVuOl98oW2hxeLMI9Io7TFWHG8
         CAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797607; x=1728402407;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F9USttcl8aLKB8K6r98GA8UU336npTclncTsz3/BjB4=;
        b=miGFjtExQcmzggJV6hvljRTdE/oEJ/oeh/Uzyn4hUGEkdr1HZdUwkrl5yPXc2h97ni
         yEJxa/BWd7rYZkuZbYLghZgMzIE/B+2jgjxKm2AT3VdVjq5SbK7O+FBtR2U/MmcKXJYp
         3GnyaNFyvW1imry0MbSOKM3Jc/tOJLVEiyuR2t45oMoeWV4IaO+kffr4MBRYE/C4a05Y
         N0+ylBWEvwHJmHBk7h7hGqATTZtwfyvnbQzQVN/5MrPjr65R/Roi24cUPZcILr3utump
         uumjCJnRiakRRDy+vqY/BSjeGSzdrg/boPdtqPRYFnI15kmS2wefmXVA1+Y1pLsoMncQ
         Hs3g==
X-Gm-Message-State: AOJu0YzUthoXh0XK9NR/cpWbHoAfNQs7xuurRoyxQxG+VNtkHgkv6PzZ
	rI6wG1+ccNcRIgUDOjU5OVAmR5qbwvrmf595uWwSEsy8+qsRp8/kk055a9wcq/U=
X-Google-Smtp-Source: AGHT+IHSlGn02yqgAZcF+tinnEAtmswScRt/03D9TMlLsjh2Ph87vW1b+1cx9Lcn6mxRNs2kMbMT/w==
X-Received: by 2002:a05:6808:3995:b0:3e0:46c1:399 with SMTP id 5614622812f47-3e3b40e311cmr180282b6e.2.1727797606792;
        Tue, 01 Oct 2024 08:46:46 -0700 (PDT)
Received: from [10.95.21.54] (syn-066-025-222-085.res.spectrum.com. [66.25.222.85])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e393579a00sm3111288b6e.3.2024.10.01.08.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 08:46:45 -0700 (PDT)
Message-ID: <bef43546-6e2c-48ad-8943-0bb7b33ac96d@gmail.com>
Date: Tue, 1 Oct 2024 10:46:43 -0500
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: util-linux@vger.kernel.org, ngupta@vflare.org
From: Soul-Rebel <thelostrebelsoul@gmail.com>
Subject: zram: Compressed RAM-based block devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi hello,

REF: https://docs.kernel.org/admin-guide/blockdev/zram.html

Reading over the document explaining zram and see some spelling errors 
in step 4 of the usage section.  the word dictionary was misspelled in 
the path example "/etc/dictioary"

#pass path to pre-trained zstd dictionary
echo "algo=zstd dict=/etc/dictioary" > /sys/block/zram0/algorithm_params

#same, but using algorithm priority
echo "priority=1 dict=/etc/dictioary" > \

         /sys/block/zram0/algorithm_params

#pass path to pre-trained zstd dictionary and compression level
echo "algo=zstd level=8 dict=/etc/dictioary" > \
         /sys/block/zram0/algorithm_params


Regards
