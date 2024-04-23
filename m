Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC628E2
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912062; cv=none; b=Lu68vMEwA7FA9AB83Hc0g5ZstGCZOv3dkYOhteMD9UXNwCC3q1VsdYX3qONK67d/oV+f8PNAg5kHE1BxkAZyaY0E+CCyUfJ7q/K9HYmZtZLrwOnwJZ5oH0QU/3asiSoxVTOLvW/Uq0q22LjFNGS/qHZ2JbYe7lby1HCe38LKpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912062; c=relaxed/simple;
	bh=JkDhJs1YIuxfd3wPdAbpgXc19G8E4wfsOaGMPP9OvZo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XRck6JU1r5D03gP4ptWjXrIU93/1kzmElYtFhE17n+NS8ZvgRyKNUwEoMl7v/oLEGdPUreLby1P9Ui1QJRnWxZE7Bvf6KUbaKB716V/acHz7Is+1HPgvLYu6UBgLWr/KKGeAX6+rCMPFlqbXbmJW6HHvNFWytr4yAk9aomZ40dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG73mEn8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG73mEn8"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b5dae6a64so3019476d6.1
        for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713912059; x=1714516859; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JkDhJs1YIuxfd3wPdAbpgXc19G8E4wfsOaGMPP9OvZo=;
        b=DG73mEn8Fwmes7cDCG5p90AMBrYkzkAN1001n3+cWGUEaW+wWYaVTQu6YDxezMUrRt
         HtO4XgbYceNOVmfCuoWTSee79UEUvaKQDYas3ECF8+Pq7wbrzin+vBcynv3eIkxadlOb
         N1mMNviG2fHOnYqTmi0M4AzWM3shGkjIyWzqxGqEOBzIgm8EpWMttC9poHf1jmT/ikml
         UW/PoNpliaBCC7v1Zj88dA+psbOEFbyFBuAokdDfMF8NUrodt7hay+6GmQWEU2h1AThQ
         FMtPGN347ozbs2lXrZBQHdLfY1xMMSrAg2I05wAiykdihGvc+r2C6SZgVKluPk9BXaaP
         W4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713912059; x=1714516859;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkDhJs1YIuxfd3wPdAbpgXc19G8E4wfsOaGMPP9OvZo=;
        b=hCfVbbi3fSLhd2tffrfMuAlKjSkSdfWNxxJYYqaYWvBDbg8ZnUEEdvjdSlr5eM2aOW
         dYhK9s+0TmqckDpoxD+cg2cM7sQF2S0t9WANZ+6MtH3KMHATjm7kylTY1o1l4ilGGpnJ
         O6ioUlk57VKJfD+iUX/Dhil6JPAspv7ciOWg/HdH8JPtG1pcF7hs6PB2TSj+7ZeYOXO7
         ngiZVLrzZikAc5aMOCNy3MriE+iPNkU6FH/toknC05Xobqa24l8DDhZmbOAb+5jRwHD+
         0a3a32UWHJJ0j9ZvGqS1XCZM2OhV32SXq9+s8QsK0XqS4nJQ+zXgXUfm5GKVEaDqvnf5
         Zy8A==
X-Gm-Message-State: AOJu0YwON3xsV5MgeYv1YKORQ4e9xVZ+64tayZ694lBQSC0Stwn+gQuV
	uJPgDHGOgTolqYbaw+Gs3JTXt3VVyoSu6gEQauGEUkCL0BaXtlImlpzcfApqjIm2W5dDrb4pFmQ
	+E0tpvNwz/ATSaOheuoYyPIYve5cu6sVlTw==
X-Google-Smtp-Source: AGHT+IFLBbV1twUqXBVqpuTPWcaBgpNjCiXQf3rO7bQlBLcHfKlTOjxCaIq7mEugVF/jd0OKWt+QsbsEKD7JDRpva2U=
X-Received: by 2002:a05:6214:19e7:b0:69b:7363:92a with SMTP id
 q7-20020a05621419e700b0069b7363092amr7389977qvc.8.1713912059515; Tue, 23 Apr
 2024 15:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Prasanna Paithankar <paithankarprasanna@gmail.com>
Date: Wed, 24 Apr 2024 04:10:48 +0530
Message-ID: <CAOfrUuZ8fL3kz=p2Pwh5JN6Nm9UvE4NPtcikNFCL8LC7r5FW0g@mail.gmail.com>
Subject: [RFC] ipcs for POSIX IPC
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,
The 'ipcs' (and 'ipcrm') command provides information on (or removes
some) System V IPC resources. I'd like to know why no similar utility
for POSIX IPC has existed for a long time. I would like to know if
such a tool exists in case I missed it. If not, I will provide patches
to ipcs and ipcrm (or should I separate the functionality into a new
utility).

Yours sincerely
Prasanna Paithankar
