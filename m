Return-Path: dave@gnu.org
Date: Mon, 17 Oct 2011 19:23:01 -0400
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 0/3] prlimit
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1318893781.5289.8.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Hi,

Here is first version of a new prlimit(1) command. I hope it will
eventually replace ulimit, as it extends the functionality to *any*
process, not just bash and kids. Please give it a test and let me know
any bugs and/or comments.

Thanks,
Davidlohr
