Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f51.google.com ([209.85.215.51]:53314 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934006Ab3BMUi1 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Feb 2013 15:38:27 -0500
Received: by mail-la0-f51.google.com with SMTP id fo13so1610085lab.38
        for <util-linux@vger.kernel.org>; Wed, 13 Feb 2013 12:38:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130213131539.GE7799@x2.net.home>
References: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
 <1360218141-4463-5-git-send-email-cmaloney@theoreticalchaos.com> <20130213131539.GE7799@x2.net.home>
From: Cody Maloney <cmaloney@theoreticalchaos.com>
Date: Wed, 13 Feb 2013 13:38:06 -0700
Message-ID: <CA+K3q6qTm+s-A=4=dgCsLzjWKis6ok9_gR2v5uvti93A5i4NoQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] chfn: Add libuser support
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Miloslav Trmac <mitr@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 13, 2013 at 6:15 AM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Feb 06, 2013 at 11:22:21PM -0700, Cody Maloney wrote:
>> @@ -149,17 +156,24 @@ int main(int argc, char **argv)
>>       }
>>  #endif
>>
>> -     /* Reality check */
>> -     if (uid != 0 && uid != oldf.pw->pw_uid) {
>                            ^^^^^^^^^^^^^^^
>> +#ifdef HAVE_LIBUSER
>> +     /* If we're setuid and not really root, disallow the password change. */
>> +     if (geteuid() != getuid() && uid != pw->pw_uid) {
>> +#else
>> +     if (uid != 0 && uid != pw->pw_uid) {
>> +#endif
>
>  Copy & past from chsh, right?
>
> login-utils/chfn.c: In function ‘main’:
> login-utils/chfn.c:161:38: error: ‘pw’ undeclared (first use in this function)
> login-utils/chfn.c:161:38: note: each undeclared identifier is
> reported only once for each function it appears in

Yes it was (And in turn based on lchsh)
>
>>               errno = EACCES;
>> -             err(EXIT_FAILURE, NULL);
>> +             err(EXIT_FAILURE, _("running UID doesn't match UID of user we're "
>> +                   "altering, change denied")););
>                                        ^^^
>>       }
>
> login-utils/chfn.c:167:37: error: expected statement before ‘)’ token
>
>
> Man, that's suid binary...
>
> Fixed and applied.
>
>     Karel

Thanks

Cody
