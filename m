Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754326Ab1KKLkZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Nov 2011 06:40:25 -0500
Date: Fri, 11 Nov 2011 12:40:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] fdisk: rewrite print menu system
Message-ID: <20111111114022.GQ16397@nb.net.home>
References: <1321006331-7633-1-git-send-email-cosoleto@gmail.com> <1321006331-7633-4-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321006331-7633-4-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 11, 2011 at 11:12:10AM +0100, Francesco Cosoleto wrote:
> +	for (i = 0; i < ARRAY_SIZE(menulist); i++)
> +		if ((menu != BSD_MENU && menulist[i].label[menu] & disklabel)
> +		    || (menu == BSD_MENU && menulist[i].label[MAIN_MENU] & OSF_LABEL))

 Why we need BSD_MENU and this if()? Why we cannot use
 print_menu(MAIN_MENU) in BSD code?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
