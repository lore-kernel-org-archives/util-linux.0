Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55976 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab1FBTd0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 Jun 2011 15:33:26 -0400
Received: by bwz15 with SMTP id 15so1204956bwz.19
        for <util-linux@vger.kernel.org>; Thu, 02 Jun 2011 12:33:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1307042126-7242-1-git-send-email-cosoleto@gmail.com>
References: <1307042126-7242-1-git-send-email-cosoleto@gmail.com>
Date: Thu, 2 Jun 2011 21:33:25 +0200
Message-ID: <BANLkTikqJmr87MQe7rgjUF+XevqW9Q7HZg@mail.gmail.com>
Subject: Re: [PATCH] simpleinit: remove NLS support
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is a little mistake in the commit message, initctl doesn't need changes:

About 50 messages to translate less.

shutdown(1) is deprecated since July 2007, simpleinit(1) is deprecated
since December 2010. They are marked as deprecated why nobody
uses these implementations.
