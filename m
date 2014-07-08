Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:62095 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977AbaGHO65 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Jul 2014 10:58:57 -0400
Received: by mail-wg0-f51.google.com with SMTP id y10so1330317wgg.22
        for <util-linux@vger.kernel.org>; Tue, 08 Jul 2014 07:58:56 -0700 (PDT)
MIME-Version: 1.0
From: Rafael Ferreira <rafael.f.f1@gmail.com>
Date: Tue, 8 Jul 2014 11:58:36 -0300
Message-ID: <CALLTvwd4SPLWosR9ko1EXoP7pyTigof_0bQmhjUzLiR6EZDi_w@mail.gmail.com>
Subject: bug report in lslogins strings
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi there.


While translating util-linux, I found one typo (unsupported with two 's'):

In file login-utils/lslogins.c, line 332:
"unssupported time type"


Also, while not a bug, I think the below strings could be changed in
order to have more consistence. Maybe line 1160 could be "users' last
failed logins" ? See:

In file login-utils/lslogins.c, line 1160:
" -f, --failed             display data about the last users' failed logins\n"

In file login-utils/lslogins.c, line 1163:
" -L, --last               show info about the users' last login sessions\n"


Cheers,
Rafael Ferreira
