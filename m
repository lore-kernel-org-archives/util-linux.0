Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="SBSOXU/h"
X-Greylist: delayed 189 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 09:26:12 PST
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E023CC0
	for <util-linux@vger.kernel.org>; Mon,  4 Dec 2023 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1701710770; x=1701969970;
	bh=WcA/cY74eBe0JfJGW1LtPxXheubudgMg6veYRPw2ae0=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SBSOXU/h+nKArQn+5Z/mWkfEGW22jIcJhW42bjCxyPrDURjlLm9Gj/1puXJswOGWY
	 xQezi5FR5B9VaS5AJ4Fe0VztjmTpIVuoe/tbZQ1VUMeW6aqNQt9u2N4SSDRSFfZV8E
	 6ueBsqDbzO1YtXueS3oEfRnBVZjhjLVRPxzGLNAwl6Po7DR49e9Mf+on9uozMvAJ0B
	 1exXUf0BKPC2/JTOnJLD/9Z/b/cGBD8N+qhiV3xvkYol8JF0qYeHXojLkjYOFCIBsb
	 qRFZ1acWAOOH7F5eVbOUEuMDj0u0LH2v42KHF+xKtdl2QHV7L2DvZnK0dHDLlIuE6/
	 O/7RNNtRZbGpA==
Date: Mon, 04 Dec 2023 17:26:05 +0000
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
From: Remigiusz Leon Suwalski <remigiusz.suwalski@protonmail.ch>
Subject: Piped `column -t` inserts extra newlines since Oct 2023
Message-ID: <StZBjLc2hfwARaOlTwkjpnqrtWLLL_rya0UmGRk5OFwX1Y1KthwQWBz5bcDpEOjcq2hbJ6aY4fcoAMU3pU2spFhGDbGwmd4puAzNrvspFpE=@protonmail.ch>
Feedback-ID: 3678023:user:proton
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
I have discovered that `column` utility behaves oddly when piped to another=
 command, as shown on examples below. I am not sure whether this is a bug o=
r intended behaviour.

First `column` built from sources (commit https://git.kernel.org/pub/scm/ut=
ils/util-linux/util-linux.git/commit/?id=3D94feb5a20d23904cc15cd857c4e00f35=
f495116c):
$ echo '_ __ ___ ________ __________ ________' | ./column -t | nl # strange
1  __
2     ___
3          ___
4                 _________
5                                       __________
6                                                                  _______
$ echo '_ __ ___ ________ __________ ________' | ./column -t > file.txt # t=
he same issue as above
$ echo '_ __ ___ ________ __________ ________' | ./column -t # expected
_  __  ___  ________  __________  ________

A workaround that works sometimes (on this and some other but not all input=
s) is to pass -c 0 option:
$ echo '_ __ ___ ________ __________ ________' | ./column -t -c 0 | nl # ex=
pected
1 _  __  ___  ________  __________  ________

Separate binary built from parent commit 3949a48dd1351cea7c523fe97666190359=
247630 behaves well:

$ echo '_ __ ___ ________ __________ ________' | ./column -t | nl
1 _  __  ___  ________  __________  ________

If it matters, the output of "tput cols" command is 252, operating system i=
s Ubuntu 22.04.3 and my locale is as follows:
LANG=3DC.UTF-8
LANGUAGE=3D
LC_CTYPE=3D"C.UTF-8"
LC_NUMERIC=3D"C.UTF-8"
LC_TIME=3D"C.UTF-8"
LC_COLLATE=3D"C.UTF-8"
LC_MONETARY=3D"C.UTF-8"
LC_MESSAGES=3D"C.UTF-8"
LC_PAPER=3D"C.UTF-8"
LC_NAME=3D"C.UTF-8"
LC_ADDRESS=3D"C.UTF-8"
LC_TELEPHONE=3D"C.UTF-8"
LC_MEASUREMENT=3D"C.UTF-8"
LC_IDENTIFICATION=3D"C.UTF-8"
LC_ALL=3D

Best regards,
Leon Suwalski
