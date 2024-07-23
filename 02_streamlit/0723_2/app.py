import streamlit as st

ani_list = ['짱구는못말려', '몬스터', '릭앤모티']
img_list = ['https://i.imgur.com/t2ewhfH.png',
            'https://i.imgur.com/ECROFMC.png',
            'https://i.imgur.com/MDKQoDc.jpg']

text = st.text_input("Type your text")
text = "몬"
# if text in ani_list:
#     st.image(img_list[ani_list.index(text)])

if text:
    for ani in ani_list:
        if text in ani:
            st.image(img_list[ani_list.index(ani)])
            st.page_link(label="링크", page=img_list[ani_list.index(ani)])
            