Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9DF433A4
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307281; cv=none; b=FZagg6q2c0b7IEyPPb79mobYCEfWqciV9/oErdGeCLVgMi59pzCuJ5dMuNJqhkeL3uqhuzzu4mSs3xfU4WWC6oFaCYBpTiA4Bf49tKzpo25UWcO2N163DgY2s/Dqn6v1AOGmW1I3DsUxPDw5WtYjBddLJRcT2nN2eRh0WK2Sa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307281; c=relaxed/simple;
	bh=77UlPlrMKpBBwm7xDPVsM8wO9tGsMxpBOxCaqKvf9lU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n66AN/gg1PvvmCzfjYrlgLZ4exZxLxpdaRcduYVxhCkPSwhljpw/jsaAXz9no6fdZvZ/EwwTuV8GXejMEmAo8AjD/4tDINKCg+Z6OV9qvl7FtrXMP3Gc/EyN8JLrds5EZ+ooYfepmSN49IraDnNgf0cjLfefRRbS0B0fOJ8syUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjRUd1Vo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjRUd1Vo"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so5189672a12.3
        for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307276; x=1751912076; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qu/2oFdK6NMzNLRiAXvW+dFMg7hJ/qfR7lNePxZAgss=;
        b=kjRUd1VoqIya2XXPHSU2jiqpC0oGwgcusJ9ZP2Sz8a6RFUFu45b1JCmwfebUPrmaYq
         ILP2RVMt48/Ucs02EilUiEzojcmAyBgyv+bAAZoAZYUDBKTr3XONrX35GQUMRfqECfqU
         VjohOB0t1c088T6xHZ2Szz1lIvzeqNiP2hSApHaNCCR4nRIMyA3G6+Lu235pyJ2McGM9
         xDwh5JXh0TRRE8ecMl2ZbNoyWhb33Exggz8PpqKKsXk8MPKvENaeq1TQqlFI645b65P4
         SWhOsoWQO/8ghr809/AoCBDJynGAodGYpUWlZ0Gh/kyyFsAxze6LEtXxAxM9j3Hejf/J
         QYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307276; x=1751912076;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qu/2oFdK6NMzNLRiAXvW+dFMg7hJ/qfR7lNePxZAgss=;
        b=YLdNTBnEv6xmotvOg3kHUaDbRHjVDckwS9MMOYXAnQP4VzJM89vc/0LiKkttM0M8hD
         hEY3NYU7Nz+MJDwyJhywrcAYDfOtsPpdZnSiFvh4IOM/jq2xbqfJqGvKpKxQN0v2dLSy
         gIjlBWsRFW4CEcVjmlnaQOwF7gIqD5vRCPS9cB6k9vDgau7dI4dN2LiuEhNHO9QSwj8W
         BOdse7nStdhxWC/pqJyQcZNNLYMd+etEqI0DKC/gCzy/O65BPTHOI8G9dmt7w4p+zM56
         tiLDDMKNlPTCQvJxuPoTSJQAgMbhx8o4gS1JWV8Ac+GRhRfQ14vzHeFob8LM78otpK2A
         Uijw==
X-Gm-Message-State: AOJu0Yy7mD9aOJMbE/uY2uEK2d1Wq+CZQhXyh5FsRarqGGXDzpvT7pTg
	NGIUxF1YWNrwHt50uo3kqhE4eA7lSGGH2GJXTUEkJDK+gMu4OX28pdaGQ30KLHYZhIljMGaopWm
	r4vXkSjaWOEJI0gaZVQv2xQeO7U3vPDmj26MTjdY=
X-Gm-Gg: ASbGnctlFAB2Wx6cc4Yl8GeROKAAXdaqJVhj5ip4PX1aJnVPSg0FQaqBKi2Agboljms
	/uGBx0I7Py77U3OndFYIDEuS9v7BK3wvVINYK1VqJg/CRsLhteqESD3nH40mA0WGdbkBM6OyNXm
	KjBAChaKdrhavRon/aCITyiaDJadlymfogXRVXMgmxoi8=
X-Google-Smtp-Source: AGHT+IF8aoMqnmBmOU8hgTECsFvJ6nGpfmz1KEl4Qv6DaKeEUR49GDWscR1rvmWbEzgi2x2v4gZellakIp49eZzq3K0=
X-Received: by 2002:a2e:a239:0:b0:32a:de39:eb4c with SMTP id
 38308e7fff4ca-32cdc4991cdmr25536211fa.18.1751307263897; Mon, 30 Jun 2025
 11:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: james smith <cinemassacres@gmail.com>
Date: Mon, 30 Jun 2025 18:14:12 +0000
X-Gm-Features: Ac12FXz9lOztf0wPvKFkp8vbR4Nk3J_b2jIi5mBgsEh6eMOVk3P2rE9B_XbSNlM
Message-ID: <CAEDMRA19oYo61ZBPaW=kMFHEJ+n7zBr4DtOgcRhp_1Ug0_Oo_Q@mail.gmail.com>
Subject: Feature Request allow using chsh unattended
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

if I do chsh -s /bin/zsh --unattended, it uses the previous
sudo/privilege escalation  used in a command, ie sudo apt update, then
chsh -s /bin/zsh --unattended it will not ask me for the password
