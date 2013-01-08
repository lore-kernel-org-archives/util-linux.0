Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64304 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3AHGSt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Jan 2013 01:18:49 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so72834ieb.20
        for <util-linux@vger.kernel.org>; Mon, 07 Jan 2013 22:18:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130107115103.GD28963@x2.redhat.com>
References: <1357183321-24637-4-git-send-email-cmaloney@theoreticalchaos.com>
 <805019865.52854570.1357230851238.JavaMail.root@redhat.com> <20130107115103.GD28963@x2.redhat.com>
From: Cody Maloney <cmaloney@theoreticalchaos.com>
Date: Mon, 7 Jan 2013 23:18:28 -0700
Message-ID: <CA+K3q6q7po0jaW3ZPFQZUf5wsECme3s2eFuSmUzbQ0cmUvJnqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] chsh: Add libuser support
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
To: unlisted-recipients:; (no To-header on input)@mail.corp.redhat.com
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I definitely don't mind depending on the newer version. I'll update
the patch(es) with both your comments, and write up the patch for
chfn. I should have them done and sent to the list in the next couple
of days.

On Mon, Jan 7, 2013 at 4:51 AM, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Jan 03, 2013 at 11:34:11AM -0500, Miloslav Trmac wrote:
>> > +   memset(&val, 0, sizeof(val));
>> > +   g_value_init(&val, G_TYPE_STRING);
>> > +   g_value_set_string(&val, shell);
>> > +
>> > +   lu_ent_clear(ent, LU_LOGINSHELL);
>> > +   lu_ent_add(ent, LU_LOGINSHELL, &val);
>> If you don't mind depending on libuser >= 0.58, all of the above can be replaced with
>> > lu_ent_set_string(ent, LU_LOGINSHELL, shell);
>> and you can drop the "g_value_unset" calls as well.
>
>  It would be nice to drop g_* junk :-)
>
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
