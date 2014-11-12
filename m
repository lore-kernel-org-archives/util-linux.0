Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:57065 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaKLUuK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 12 Nov 2014 15:50:10 -0500
Received: by mail-wg0-f53.google.com with SMTP id b13so15203316wgh.40
        for <util-linux@vger.kernel.org>; Wed, 12 Nov 2014 12:50:08 -0800 (PST)
Date: Wed, 12 Nov 2014 20:50:01 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: kerolasa@gmail.com, Karel Zak <kzak@redhat.com>,
        Boris Egorov <egorov@linux.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
In-Reply-To: <20141112195131.GA3902@vapier.wh0rd.info>
Message-ID: <alpine.LNX.2.03.1411122044080.18829@iki.fi>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi> <5461B803.4050707@linux.com> <CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com> <alpine.LNX.2.03.1411112236560.23899@iki.fi> <20141112142500.GB5530@x2.net.home>
 <CAG27Bk2-c4_AsqCsBd+uBkkcvX0CSJPW+Q2+JndyGts=ZE1rmw@mail.gmail.com> <20141112195131.GA3902@vapier.wh0rd.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 12 Nov 2014, Mike Frysinger wrote:

> On 12 Nov 2014 15:02, Sami Kerola wrote:
>> On 12 November 2014 14:25, Karel Zak <kzak@redhat.com> wrote:
>>> On Tue, Nov 11, 2014 at 10:49:02PM +0000, Sami Kerola wrote:
>>>>       printf(_("Setting up swapspace version %d, size = %s (%ju bytes)\n"),
>>>>               version, strsz, sz);
>>>> +     free(strsz);
>>>
>>>  free-before-exit, you know what I think about it, right? :)
>>
>> Normally I would agree, but this case is bizarre. The mkswap will
>> return 1 when compiled with clang -fsanitize=address without any
>> message what is wrong. That's probably clang bug, which is a different
>> topic all together. Adding the free() calls seems to make the
>> immediate tests failure issue to go away, that is needed to automate
>> sanitize. In case travis && address sanitation is not needed at all
>> then these changes does not make sense.
>
> i don't think adding a free to avoid a bug in clang is justified
>
> at least gcc defines __SANITIZE_ADDRESS__ ... so you might be able to gate on
> that with a comment pointing to an open bug report on the clang side

Hi Mike,

I like the idea, let me give a try to it.

$ git diff
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index d34e2fd..895d1ec 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -347,7 +347,7 @@ static void write_header_to_device(struct mkswap_control *ctl)
                         ctl->devname);
  }

-int main(int argc, char **argv)
+int UL_ASAN_BLACKLIST main(int argc, char **argv)
  {
         struct mkswap_control ctl = { .fd = -1 };
         int c;
@@ -489,7 +489,6 @@ int main(int argc, char **argv)

         printf(_("Setting up swapspace version %d, size = %s (%ju bytes)\n"),
                 version, strsz, sz);
-       free(strsz);

         set_signature(&ctl);
         set_uuid_and_label(&ctl);
diff --git a/include/c.h b/include/c.h
index 0f6e5b2..c581d73 100644
--- a/include/c.h
+++ b/include/c.h
@@ -313,4 +313,21 @@ static inline int xusleep(useconds_t usec)
  #define stringify_value(s) stringify(s)
  #define stringify(s) #s

+/*
+ * UL_ASAN_BLACKLIST is a macro to tell AddressSanitizer (a compile-time
+ * instrumentation shipped with Clang and GCC) to not instrument the
+ * annotated function.  Furthermore, it will prevent the compiler from
+ * inlining the function because inlining currently breaks the
+ * blacklisting mechanism of AddressSanitizer.
+ */
+#if defined(__has_feature)
+# if __has_feature(address_sanitizer)
+#  define UL_ASAN_BLACKLIST __attribute__((no_sanitize_address))
+# else
+#  define UL_ASAN_BLACKLIST    /* nothing */
+# endif
+#else
+# define UL_ASAN_BLACKLIST     /* nothing */
+#endif
+
  #endif /* UTIL_LINUX_C_H */

I borrowed the above from mozilla source.
http://dxr.mozilla.org/mozilla-central/source/mfbt/Attributes.h

There is just one catch.  After compiling with no_sanitize_address 
instrumentation the return value issue is back.

$ ./mkswap test ; echo $?
lt-mkswap: test: warning: wiping old swap signature.
Setting up swapspace version 1, size = 96 KiB (98304 bytes)
no label, UUID=1aeb88e8-6442-4e0f-93a5-118271b026c0
1	<--- is the issue

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
