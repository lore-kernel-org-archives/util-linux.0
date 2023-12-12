Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="lVOgKHu4"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484FBD
	for <util-linux@vger.kernel.org>; Tue, 12 Dec 2023 10:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1702406783; bh=WUQs1irEToynaa7eiWWypLbGevMErCzvv9b+wU/uqgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVOgKHu4QI2LX+GRYUYsBCIg5Ju7C6lYVt/scDjU3teaDgUAr2G4StzFeujk1e4TD
	 KFPBshmaX4QyKc1r+GE+//aYoBiWsyLxyJYNA3eShbUzaPqW86S6QH7JJBlK0zhARU
	 oOmF4tBo1tqE7lrjW0UYFN43JmaIJMUo+buWddRE=
Date: Tue, 12 Dec 2023 19:46:23 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Edward Chron <echron@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] Add dmesg syslog interface tests for PRINTK_CALLER field
Message-ID: <a8f0a8e8-d09f-487a-abd4-af11461afb28@t-8ch.de>
References: <20231209222019.954-1-echron@arista.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209222019.954-1-echron@arista.com>

Hi,

thanks for the tests!

On 2023-12-09 14:20:19-0800, Edward Chron wrote:
> Submission to Project: util-linux
> Open Incident: #2637 at github.com/util-linux/util-linux/issues/2637
> Component: util-linux/sys-utils
> File: dmesg.c
> Code level patch applied against: https://github.com/t-8ch/util-linux/
>      and we used his local-dmesg-tests from t8ch/dmesg/tests
>      as we needed the numerous improvements and fixes that Thomas has
>      made to the code.
> 

[..]

> Tests include syslog-printk-caller versions of all existing tests:
> 
> -------------------- util-linux regression tests --------------------
> 
>                     For development purpose only.
>                  Don't execute on production system!
> 
>        kernel: 6.6.4-200.fc39.x86_64
> 
>       options: --srcdir=/usr/src/util-linux/pending/util-linux/tests/.. \
>                --builddir=/usr/src/util-linux/pending/util-linux/tests/..
> 
>         dmesg: colors                         ... OK
>         dmesg: colors-syslog-prtk-caller      ... OK
>         dmesg: levels                         ... OK
>         dmesg: levels-syslog-prtk-caller      ... OK
>         dmesg: decode                         ... OK
>         dmesg: decode-syslog-prtk-caller      ... OK
>         dmesg: delta                          ... OK
>         dmesg: delta-syslog-prtk-caller       ... OK
>         dmesg: facilities                     ... OK
>         dmesg: facilities-syslog-prtk-caller  ... OK
>         dmesg: indentation                    ... OK
>         dmesg: indent-syslog-printk-caller    ... OK
>         dmesg: limit                          ... OK
>         dmesg: limit-syslog-prtk-caller       ... OK

Do we need so many new testcases?
Wouldn't two tests be enough to be sure that the new logic works?

One for the syslog parsing logic and one for the /dev/kmsg one?

Thomas
